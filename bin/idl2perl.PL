use Config;
use File::Basename qw(basename dirname);
chdir(dirname($0));
($file = basename($0)) =~ s/\.PL$//;
$file =~ s/\.pl$//
        if ($Config{'osname'} eq 'VMS' or
            $Config{'osname'} eq 'OS2');  # "case-forgiving"
open OUT,">$file" or die "Can't create $file: $!";
chmod(0755, $file);
print "Extracting $file (with variable substitutions)\n";

print OUT <<"!GROK!THIS!";
$Config{'startperl'} -w
    eval 'exec perl -S \$0 "\$@"'
        if 0;

!GROK!THIS!

print OUT <<'!NO!SUBS!';
# $Id: idl2perl.PL,v 1.5 1997/07/25 10:12:40 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

# use Carp;
# BEGIN { $SIG{__WARN__} = $SIG{__DIE__} = sub { confess @_ } }
use strict;
use Getopt::Long;
use IO::File;
use File::Path;

my %options;

$options{'scoped-enums'} = 1;
$options{skeleton} = 1;
$options{impl} = 0;
$options{strict} = 1;
$options{prototypes} = 1;
$options{outdir} = 'out';    # ='.' is ok, but NOT =''  !!!
@::SAVE_ARGV = @ARGV;
GetOptions( \%options, 'skeleton!', 'impl!', 'scoped-enums!', 'prototypes!', 'subdirs!', 'strict!', 'outdir:s', 'irref:s');

use COPE::CORBA::ORB;
use COPE::IR;

IDLCompiler::init_tc_lookup();

my $orb = CORBA::ORB_init();

my($irref,$irfh,$pid);
if ($options{irref}) {
    $irref = `cat $options{irref}`;
} else {
    $irfh = new IO::File;
    $pid = open($irfh, '-|');
    if (!$pid) {
        exec "irserv --ior $ARGV[0]";
        die "exec failed: $!";
    }
    $irref = <$irfh>;

    die "Child process died!\n" if !kill 0, $pid;	# FIX Jul-17-1997

}
chomp $irref;
my $obj = $orb->string_to_object($irref);
my $ir = CORBA::Repository->_narrow($obj);

foreach (@{$ir->contents(CORBA::DefinitionKind::dk_all, 1)}) {
    my $out = new IDLCompiler::Output(\%options);
    $out->name($_->name());
    IDLCompiler::compile($out, $_);
    $out->flush();
}

if (!$options{irref}) {
    kill 'TERM', $pid;
    $irfh->close;
}

package IDLCompiler;
use COPE::CORBA::TypeCode;
use COPE::CORBA::TCKind;

sub compile ($$) {
    my($out,$object) = @_;
    my $dk = $object->def_kind;
    if ($dk == CORBA::DefinitionKind::dk_Module) {
        compile_Module($out,CORBA::ModuleDef->_narrow($object));
    } elsif ($dk == CORBA::DefinitionKind::dk_Enum) {
        compile_Enum($out,CORBA::EnumDef->_narrow($object));
    } elsif ($dk == CORBA::DefinitionKind::dk_Struct) {
        compile_Struct($out,CORBA::StructDef->_narrow($object));
    } elsif ($dk == CORBA::DefinitionKind::dk_Alias) {
        compile_Alias($out,CORBA::AliasDef->_narrow($object));
    } elsif ($dk == CORBA::DefinitionKind::dk_Interface) {
        compile_Interface($out,CORBA::InterfaceDef->_narrow($object));
    } elsif ($dk == CORBA::DefinitionKind::dk_Attribute) {
        compile_Attribute($out,CORBA::AttributeDef->_narrow($object));
    } elsif ($dk == CORBA::DefinitionKind::dk_Operation) {
        compile_Operation($out,CORBA::OperationDef->_narrow($object));
    } elsif ($dk == CORBA::DefinitionKind::dk_Exception) {
        compile_Exception($out,CORBA::ExceptionDef->_narrow($object));
    } elsif ($dk == CORBA::DefinitionKind::dk_Constant) {
        compile_Constant($out,CORBA::ConstantDef->_narrow($object));
    } else {
        print "Skipping dk = $dk\n";
    }
}

sub compile_Module ($$) {
    my($out,$module)= @_;
    $out->types_comment("# " . $module->id . "\n");
    $out->push_package($module->name);
    foreach (@{$module->contents(CORBA::DefinitionKind::dk_all, 1)}) {
        compile($out,$_);
    }
    $out->pop_package();
    $out->types_comment("\n");
}

sub compile_Alias ($$) {
    my($out,$alias)= @_;
    $out->types_comment("# " . $alias->id . "\n");
    $out->push_package($alias->name);
    my $name;
    if ($options{strict}) {
        $name = '$' . join('::', @{$out->{'package'}}) . '::';
    } else {
        $name = '$';
    }
    $name .= "_tc";
    $out->types("$name = ");
    my $iro = $alias->original_type_def;
    my $tc = $iro->type;
    $out->types(tc_as_ref($tc, $name));
    $out->types(";\n\n");
    $out->pop_package();
}

sub compile_Enum ($$) {
    my($out,$enum) = @_;
    $out->types_comment("# ", $enum->id, "\n");
    if ($options{'scoped-enums'}) {
        $out->push_package($enum->name);
    }
    my $name;
    if ($options{strict} || !$options{'scoped-enums'}) {
        $name = '$' . join('::', @{$out->{'package'}}) . '::';
    } else {
        $name = '$';
    }
    $name .= "_tc";
    $out->types("$name = ", tc_as_perl($enum->type, $name), ";\n");
    my $counter = 0;
    foreach (@{$enum->members}) {
        $out->types("sub $_ () {$counter}\n");
        $counter++;
    }
    $out->types_comment("\n");
    if ($options{'scoped-enums'}) {
        $out->pop_package();
    }
}

sub compile_Struct ($$) {
    my($out,$struct) = @_;
    $out->types_comment("# ", $struct->id, "\n");
    $out->push_package($struct->name);
    if ($options{strict}) {
        $out->types('@', join('::', @{$out->{'package'}}), '::');
    } else {
        $out->types('@');
    }
    $out->types("ISA=qw(CORBA::_Struct);\n");
    my $name;
    if ($options{strict}) {
        $name = '$' . join('::', @{$out->{'package'}}) . '::';
    } else {
        $name = '$';
    }
    $name .= "_tc";
    $out->types("$name = ", tc_as_perl($struct->type, $name), ";\n\n");
    $out->pop_package();
}

sub compile_Constant ($$) {
    my($out,$constant) = @_;
    $out->types_comment("# ", $constant->id, "\n");
    if ($options{strict}) {
        $out->types('$', join('::', @{$out->{'package'}}), '::');
    } else {
        $out->types('$');
    }
    $out->types($constant->name, ' = ');
    my $value = $constant->value();
    my $kind = $value->{_type}->_noalias_kind();
    if (($kind == tk_char) || ($kind == tk_string)) {
        $out->types("'", $value->{_value}, "'");
    } else {
        $out->types($value->{_value});
    }
    $out->types(";\n");
}

sub compile_Exception ($$) {
    my($out,$exception) = @_;
    $out->types_comment("# ", $exception->id, "\n");
    $out->push_package($exception->name);
    if ($options{strict}) {
        $out->types('@', join('::', @{$out->{'package'}}), '::');
    } else {
        $out->types('@');
    }
    $out->types("ISA=qw(CORBA::UserException);\n");
    my $name;
    if ($options{strict}) {
        $name = '$' . join('::', @{$out->{'package'}}) . '::';
    } else {
        $name = '$';
    }
    $name .= "_tc";
    $out->types("$name = ", tc_as_perl($exception->type, $name), ";\n\n");
    $out->pop_package();
}

sub compile_Interface ($$) {
    my($out,$interface) = @_;
    my $interface_id = $interface->id;
    my $s = "# $interface_id\n";
    $out->stub_comment($s);
    $out->skel_comment($s);
    $out->impl_comment($s);
    $out->types_comment($s);
    $out->push_package($interface->name);
    my $interface_name = join('::', @{$out->{'package'}});
    $out->skel("push \@${interface_name}_impl::ISA, 'CORBA::Object';\n");
    if ($options{strict}) {
        $out->stub('@', $interface_name, '::');
        $out->skel('@', $interface_name, '_skel::');
        $out->impl('@', $interface_name, '_impl::');
    } else {
        $out->stub('@');
        $out->skel('@');
        $out->impl('@');
    }
    my $base_interfaces = $interface->base_interfaces;
    $out->stub("ISA=qw(");
    $out->stub(join(' ', map(    {$_->absolute_name} 
                                @$base_interfaces),
                         'CORBA::Object' ));
    $out->stub(");\n");
    $out->skel("ISA=qw(CORBA::Object);\n");
    $out->impl("ISA=qw(");
    $out->impl(join(' ', map(    {$_->absolute_name . '_impl'} 
                                @$base_interfaces) ));
    $out->impl(");\n");
    my $name;
    if ($options{strict}) {
        $name = '$' . join('::', @{$out->{'package'}}) . '::';
    } else {
        $name = '$';
    }
    $name .= "_tc";
    $out->types("$name = ");
    $out->types(tc_as_perl($interface->type, $name));
    $out->types(";\n\n");

    if ($options{strict}) {
        $out->skel('$', join('::', @{$out->{'package'}}), '_skel::');
    } else {
        $out->skel('$');
    }
    $out->skel("_id = 0;\n\n");
    $out->skel(<<EOT);
sub new {
    my(\$class,\@args) = \@_;
    my \$impl = ${interface_name}_impl->new(\@args);
    my \$self = bless \$CORBA::BOA::_The_Boa->_create('$interface_id ' . \$${interface_name}_skel::_id++, '$interface_id', \$impl), \$class;
    return \$impl;
}

EOT
    $out->impl(<<EOT);
sub new {
    my(\$class,\@args) = \@_;
    my \$self = {};
    return bless \$self, \$class;
}

EOT
    foreach (@{$interface->contents(CORBA::DefinitionKind::dk_all, 1)}) {
        compile($out,$_);
    }
    $out->pop_package();
}

sub compile_Attribute ($$) {
    my($out,$attribute) = @_;
    my $s = "# ". $attribute->id. "\n";
    $out->stub_comment($s);
    $out->skel_comment($s);
    $out->impl_comment($s);
    my $name = $attribute->name;
    $out->stub("sub $name");
    $out->skel("sub $name");
    $out->impl("sub $name");
    my $mode = $attribute->mode;
    if ($options{prototypes}) {
        $out->stub(' ($');
        $out->skel(' ($$)');
        $out->impl(' ($');
        if ($mode != CORBA::AttributeMode::ATTR_READONLY) {
            $out->stub(';$');
            $out->impl(';$');
        }
        $out->stub(')');
        $out->impl(')');
    }
    $out->stub(" {\n");
    $out->skel(" {\n");
    $out->impl(" {\n");
    $out->stub('    my($self,@rest) = @_;', "\n");
    $out->skel('    my($self,$serverrequest) = @_;', "\n");
    $out->impl('    my($self');
    if ($mode != CORBA::AttributeMode::ATTR_READONLY) {
        $out->impl(',$newval');
    }
    $out->impl(') = @_;', "\n");
    if ($mode != CORBA::AttributeMode::ATTR_READONLY) {
        $out->skel("    if (\$serverrequest->op_name() eq '_set_$name') {\n");
        $out->skel('        my $arg_list = [', "\n");
        $out->skel("            { 'argument'  =>\n");
        $out->skel('              { _type  => ');
        $out->skel(tc_as_ref($attribute->type), " },\n");
        $out->skel("              'arg_modes' => 0,\n");
        $out->skel("            },\n");
        $out->skel("        ];\n");
        $out->skel("        \$serverrequest->params(\$arg_list);\n");
        $out->skel("        \$self->{impl}->$name(\n");
        $out->skel("            \$arg_list->[0]{argument}{_value}\n");
        $out->skel("        );\n");
        $out->skel("    } else {\n");
        $out->skel('        my $result_ = { _type => ');
        $out->skel(tc_as_ref($attribute->type));
        $out->skel(" };\n");
        $out->skel("        \$serverrequest->params([]);\n");
        $out->skel("        \$serverrequest->result(\$result_);\n");
        $out->skel("        \$result_->{_value} = \$self->{impl}->$name();\n");
        $out->skel("    }\n");
        $out->impl("    if (defined \$newval) {\n");
        $out->impl("        \$self->{'$name'} = \$newval;\n");
        $out->impl("    } else {\n");
        $out->impl("        return \$self->{'$name'};\n");
        $out->impl("    }\n");
    } else {
        $out->skel('    my $result_ = { _type => ');
        $out->skel(tc_as_ref($attribute->type));
        $out->skel(" };\n");
        $out->skel("    \$serverrequest->params([]);\n");
        $out->skel("    \$serverrequest->result(\$result_);\n");
        $out->skel("    \$result_->{_value} = \$self->{impl}->$name();\n");
        $out->impl("    return \$self->{'$name'};\n");
    }
    $out->stub("    return \$self->_attribute('$name', ");
    $out->stub(tc_as_ref($attribute->type));
    $out->stub(", \@rest);\n");
    $out->stub("}\n\n");
    $out->skel("}\n\n");
    $out->impl("}\n\n");
}

sub compile_Operation ($$) {
    my($out,$operation) = @_;
    my $s = "# ". $operation->id. "\n";
    $out->stub_comment($s);
    $out->skel_comment($s);
    $out->impl_comment($s);
    my $name = $operation->name;
    $out->stub("sub $name");
    $out->skel("sub $name");
    $out->impl("sub $name");
    my $params = $operation->params;
    if ($options{prototypes}) {
        $out->stub(" (", '$' x (1+scalar @$params), ")");
        $out->impl(" (", '$' x (1+scalar @$params), ")");
        $out->skel(' ($$)');
    }
    $out->stub(" {\n");
    $out->skel(" {\n");
    $out->impl(" {\n");
    $out->stub('    my($self');
    $out->impl('    my($self');
    foreach (@$params) {
        $out->stub(',$', $_->{'name'});
        $out->impl(',$', $_->{'name'});
    }
    $out->stub(') = @_;', "\n");
    $out->impl(') = @_;', "\n");
    $out->skel('    my($self,$serverrequest) = @_;', "\n");
    my $result = $operation->result;
    $out->stub('    my $result_ = { _type => ');
    $out->stub(tc_as_ref($result));
    $out->stub(" };\n");
    if ($result->kind() != tk_void) {
        $out->skel('    my $result_ = { _type => ');
        $out->skel(tc_as_ref($result));
        $out->skel(" };\n");
    }
    $out->stub('    my $request_ = $self->create_request(', "\n");
    $out->stub("        'operation' => '$name',\n");
    $out->stub("        'arg_list'  => [\n");
    $out->skel('    my $arg_list = [', "\n");
    foreach (@$params) {
        $out->stub("        { 'argument'  =>\n");
        $out->skel("        { 'argument'  =>\n");
        $out->stub('          { _type  => ');
        $out->skel('          { _type  => ');
        $out->stub(tc_as_ref($_->{type}));

        $out->skel(tc_as_ref($_->{type}));
        if ($_->{'mode'} == CORBA::ParameterMode::PARAM_OUT()) {
            if ((($_->{type}->_noalias_kind() == tk_sequence) || ($_->{type}->_noalias_kind() == tk_array)) && ($_->{type}->_noalias_content_type()->_noalias_kind() != tk_octet)) {
                $out->skel(', _value => []');
            } elsif ($_->{type}->_noalias_kind() == tk_struct) {
                $out->skel(', _value => {}');
            }
        }
        $out->skel(" },\n");

        $out->stub(', _value => $', $_->{'name'}, " },\n");
        $out->stub("          'arg_modes' => $_->{'mode'},\n");
        $out->skel("          'arg_modes' => $_->{'mode'},\n");
        $out->stub("        },\n");
        $out->skel("        },\n");
    }
    $out->stub("                       ],\n");
    $out->skel("    ];\n");
    $out->stub("        'result'    => \$result_,\n");
    $out->stub("    );\n");
    $out->stub("    \$request_->invoke(0);\n");
    if ($result->kind() != tk_void) {
        $out->stub("    return \$result_->{_value};\n");
    }
    $out->stub("}\n\n");
    $out->impl("}\n\n");
    $out->skel('    $serverrequest->params($arg_list);', "\n");
    if ($result->kind() != tk_void) {
        $out->skel('    $serverrequest->result($result_);', "\n");
        $out->skel('    $result_->{_value} = ');
    } else {
        $out->skel('    ');
    }
    $out->skel('$self->{impl}->', "$name(\n");
    my $i = 0;
    foreach (@$params) {
        $out->skel('        ');
        if ($_->{type}->_needs_ref($_->{mode})) {
            $out->skel('\\');
        }
        $out->skel('$arg_list->[', $i++, "]{argument}{_value},\n");
    }
    $out->skel("    );\n");
    $out->skel("}\n\n");
}

sub tc_as_perl ($;$) {
    my($tc, $name) = @_;
    my $retval;
    $IDLCompiler::tc{$tc} = $name if defined $name;
    my $kind = $tc->kind;
    if ($kind == tk_struct) {
        my $id = $tc->id;
        my $name = $tc->name;
        $retval = "CORBA::TypeCode::_create_struct_tc('$id', '$name', [";
        my $count = $tc->member_count;
        my $prefix = '';
        for (my $counter = 0; $counter < $count; $counter++) {
            $retval .= $prefix. "'". $tc->member_name($counter). "' => ";
            $retval .= tc_as_ref($tc->member_type($counter));
            $prefix = ", ";
        }
        $retval .= "])";
        return $retval;
    }
    if ($kind == tk_except) {
        my $id = $tc->id;
        my $name = $tc->name;
        $retval = "CORBA::TypeCode::_create_exception_tc('$id', '$name', [";
        my $count = $tc->member_count;
        my $prefix = '';
        for (my $counter = 0; $counter < $count; $counter++) {
            $retval .= $prefix. "'". $tc->member_name($counter). "' => ";
            $retval .= tc_as_ref($tc->member_type($counter));
            $prefix = ", ";
        }
        $retval .= "])";
        return $retval;
    }
    if ($kind == tk_objref) {
        my $id = $tc->id;
        my $name = $tc->name;
        return "CORBA::TypeCode::_create_interface_tc('$id', '$name')";
    }
    if ($kind == tk_alias) {
        my $id = $tc->id;
        my $name = $tc->name;
        $retval = "CORBA::TypeCode::_create_alias_tc('$id', '$name', ";
        $retval .= tc_as_ref($tc->content_type);
        $retval .= ")";
        return $retval;
    }
    if ($kind == tk_enum) {
        my $id = $tc->id;
        my $name = $tc->name;
        $retval = "CORBA::TypeCode::_create_enum_tc('$id', '$name', [";
        my $count = $tc->member_count;
        my $prefix = '';
        for (my $counter = 0; $counter < $count; $counter++) {
            $retval .= $prefix. "'". $tc->member_name($counter). "'";
            $prefix = ", ";
        }
        $retval .= "])";
        return $retval;
    }
    if ($kind == tk_sequence) {
        my $length = $tc->length;
        $retval = "CORBA::TypeCode::_create_sequence_tc($length, ";
        $retval .= tc_as_ref($tc->content_type);
        $retval .= ")";
        return $retval;
    }
    if ($kind == tk_array) {
        my $length = $tc->length;
        $retval = "CORBA::TypeCode::_create_array_tc($length, ";
        $retval .= tc_as_ref($tc->content_type);
        $retval .= ")";
        return $retval;
    }
    if ($kind == tk_string) {
        my $length = $tc->length;
        return "CORBA::TypeCode::_create_string_tc($length)";
    }
    die "internal error, obsolete code called"; my $out = 0;
    print $out "bless({\n";
    while(my($key,$val) = each %$tc) {
        if (($key eq '_name') || ($key eq '_id')) {
            print $out "    $key => '$val',\n";
        } elsif ($key eq '_kind') {
            print $out "    $key => $val,\n";
        } elsif ($key eq '_length') {
            print $out "    $key => $val,\n";
        } elsif ($key eq '_members') {
            print $out "    $key => [\n";
            foreach my $member (@$val) {
                print $out "{ ";
                while(my($mkey,$mval) = each %$member) {
                    if ($mkey eq '_name') {
                        print $out "$mkey => '$mval', ";
                    } elsif ($mkey eq '_type') {
                        print $out "$mkey => ";
                        print_tc_as_ref($out, $mval);
                        print $out ", ";
                    } else {
                        print $out "****$mkey => '$mval', ";
                    }
                }
                print $out "},\n";
            }
            print $out "],\n";
        } elsif ($key eq '_type') {
            print $out "    $key => ";
            print_tc_as_ref($out, $val);
            print $out ",\n";
        } else {
            print $out "***    $key => $val,\n";
        }
    }
    print $out "}, 'CORBA::TypeCode')";
}

BEGIN {
%IDLCompiler::has_id_and_name = map { $_ => 1 } (tk_objref, tk_struct, tk_union, tk_enum, tk_alias, tk_except);
}

sub tc_as_ref ($) {
    my($tc) = @_;
    my $retval;
    if ($IDLCompiler::has_id_and_name{$tc->kind}) {
        $retval = '$'. CORBA::ORB::_id2package($tc->id). '::_tc';
    } elsif ($IDLCompiler::tc{$tc}) {
        $retval = $IDLCompiler::tc{$tc};
    } elsif ($tc->{_id} && $IDLCompiler::tc{$tc->{_id}}) {
        $retval = $IDLCompiler::tc{$tc->{_id}};
    } elsif ($tc->kind <= 13) {
        $retval = $IDLCompiler::tc{$tc->kind};
    } else {
        $retval = tc_as_perl($tc);
    }
    return $retval;
}

sub init_tc_lookup {
    $IDLCompiler::tc{0} = '$CORBA::_tc_null';
    $IDLCompiler::tc{1} = '$CORBA::_tc_void';
    $IDLCompiler::tc{2} = '$CORBA::_tc_short';
    $IDLCompiler::tc{3} = '$CORBA::_tc_long';
    $IDLCompiler::tc{4} = '$CORBA::_tc_ushort';
    $IDLCompiler::tc{5} = '$CORBA::_tc_ulong';
    $IDLCompiler::tc{6} = '$CORBA::_tc_float';
    $IDLCompiler::tc{7} = '$CORBA::_tc_double';
    $IDLCompiler::tc{8} = '$CORBA::_tc_boolean';
    $IDLCompiler::tc{9} = '$CORBA::_tc_char';
    $IDLCompiler::tc{10} = '$CORBA::_tc_octet';
    $IDLCompiler::tc{11} = '$CORBA::_tc_any';
    $IDLCompiler::tc{12} = '$CORBA::_tc_TypeCode';
    $IDLCompiler::tc{13} = '$CORBA::_tc_Principal';
}

package IDLCompiler::Output;

sub new {
    my($class,$options) = @_;
    my $self = {};

    make_dir($options->{outdir});

    $self->{stub} = {data => '', 'package' => 0};
    $self->{skel} = {data => '', 'package' => 0};
    $self->{types} = {data => '', 'package' => 0};
    $self->{impl} = {data => '', 'package' => 0};
    $self->{'package'} = [];
    $self->{'options'} = $options;

    return bless $self, $class;
}

sub push_package ($$) {
    my($self,$package) = @_;
    push @{$self->{'package'}}, $package;
}

sub pop_package ($) {
    my($self) = @_;
    pop @{$self->{'package'}};
}

sub flush {
    my($self) = @_;
    my $options = $self->{options};

    my $date = scalar localtime;
    my $fh;
    $fh = new IO::File ">$options->{outdir}/$self->{name}.pm" or die "open >$options->{outdir}/$self->{name}.pm failed: $!";
    $fh->print(<<EOT);
# Automatically generated stub code, DO NOT EDIT.
# Generated on $date with the following command:
EOT
    $fh->print("# $0 ", join(' ', @::SAVE_ARGV), "\n\n");
    $fh->print("use $self->{name}_types;\n\n");
    $fh->print($self->{stub}{data});
    $fh->print("\n1;\n");
    $fh->close();
    if ($options->{skeleton}) {
        $fh = new IO::File ">$options->{outdir}/$self->{name}_skel.pm" or die "open >$options->{outdir}/$self->{name}_skel.pm failed: $!";
        $fh->print(<<EOT);
# Automatically generated skeleton code, MODIFICATIONS WILL BE LOST.
# Generated on $date with the following command:
EOT
        $fh->print("# $0 ", join(' ', @::SAVE_ARGV), "\n\n");
        $fh->print("use $self->{name}_types;\n");
        $fh->print("use $self->{name}_impl;\n\n");
        $fh->print($self->{skel}{data});
        $fh->print("\n1;\n");
        $fh->close();
    }
    $fh = new IO::File ">$options->{outdir}/$self->{name}_types.pm" or die "open >$options->{outdir}/$self->{name}_types.pm failed: $!";
    $fh->print(<<EOT);
# Automatically generated type code, DO NOT EDIT.
# Generated on $date with the following command:
EOT
    $fh->print("# $0 ", join(' ', @::SAVE_ARGV), "\n\n");
    $fh->print("use COPE::CORBA::TypeCode;\nuse COPE::CORBA::Object;\n\n");
    $fh->print($self->{types}{data});
    $fh->print("\n1;\n");
    $fh->close();
    if ($options->{impl}) {
        $fh = new IO::File ">$options->{outdir}/$self->{name}_impl.pm" or die "open >$options->{outdir}/$self->{name}_impl.pm failed: $!";
        $fh->print(<<EOT);
# Automatically generated sample implementation code, PLEASE EDIT.
# Generated on $date with the following command:
EOT
        $fh->print("# $0 ", join(' ', @::SAVE_ARGV), "\n\n");
        $fh->print("use $self->{name}_types;\n\n");
        $fh->print($self->{impl}{data});
        $fh->print("\n1;\n");
        $fh->close();
    }
    $self->{flushed} = 1;
}

sub DESTROY {
    my($self) = @_;
    if (!$self->{flushed}) {
        $self->flush();
    }
}

sub name {
    my($self,$name) = @_;
    $self->{name} = $name;
}

sub stub {
    my($self,@data) = @_;
    $self->to_destination('stub', @data);
}

sub skel {
    my($self,@data) = @_;
    $self->to_destination('skel', @data);
}

sub types {
    my($self,@data) = @_;
    $self->to_destination('types', @data);
}

sub impl {
    my($self,@data) = @_;
    $self->to_destination('impl', @data);
}

sub to_destination {
    my($self,$destination, @data) = @_;
    my $package = join('::', @{$self->{'package'}});
    if ($destination eq 'skel') {
        $package .= "_skel";
    } elsif ($destination eq 'impl') {
        $package .= "_impl";
    }
    if ($self->{$destination}{'package'} ne $package) {
        $self->{$destination}{data} .= "package $package;\n";
        $self->{$destination}{'package'} = $package;
    }
    $self->{$destination}{data} .= join('', @data);
}

sub stub_comment {
    my($self,@data) = @_;
    $self->{'stub'}{data} .= join('', @data);
}

sub skel_comment {
    my($self,@data) = @_;
    $self->{'skel'}{data} .= join('', @data);
}

sub types_comment {
    my($self,@data) = @_;
    $self->{'types'}{data} .= join('', @data);
}

sub impl_comment {
    my($self,@data) = @_;
    $self->{'impl'}{data} .= join('', @data);
}

sub make_dir {
    my($dir) = @_;
    if (! -d $dir) {
#        mkdir $dir, 0777 or die "mkdir $dir failed: $!";
	File::Path::mkpath([$dir], 0, 0777) or die "mkpath $dir failed: $!";
    }
}

__END__

=head1 NAME

idl2perl - translate CORBA IDL to Perl modules

=head1 SYNOPSIS

 idl2perl [--impl] <file.idl>

=head1 DESCRIPTION

This program creates a directory called C<out> if it doesn't already exist
and writes four files for every top-level construct found in the IDL file.

!NO!SUBS!
