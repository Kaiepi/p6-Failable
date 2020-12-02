use v6;
use nqp;
unit class Failable:ver<0.1.2>:auth<github:Kaiepi>;

my Mu:U %cache{ObjAt:D};

method ^parameterize(Mu:U $, Mu:_ \T --> Mu:U) {
    my ObjAt:D $which := T.WHICH;
    return %cache{$which} if %cache{$which}:exists;

    my Str:D  $name        = 'Failable[' ~ T.^name ~ ']';
    my Mu:U   $refinee     = nqp::istype(T, Any) ?? Any !! Mu;
    my Code:D $refinement  = { $_ ~~ T | Failure:D };
    my        $failable   := Metamodel::SubsetHOW.new_type: :$name, :$refinee, :$refinement;
    $*W.add_object_if_no_sc: $failable if nqp::isconcrete(nqp::getlexdyn('$*W'));

    %cache{$which} := $failable;
}

=begin pod

=head1 NAME

Failable - Failure sum type

=head1 SYNOPSIS

=begin code :lang<perl6>

use Failable;

sub cat(*@params --> Str:D) {
    my Proc:D $proc = run "cat", |@params, :out, :err;
    my Str:D  $out  = $proc.out.slurp(:close);
    my Str:D  $err  = $proc.err.slurp(:close);
    fail $err if $err;
    $out
}

my Failable[Str:D] $output = cat "/etc/hosts";
say $output.WHAT; # OUTPUT: (Str)

my Failable[Str:D] $error = cat '.';
say $error.WHAT; # OUTPUT: (Failure)

=end code

=head1 DESCRIPTION

Failable is a class for creating Failure sum types. Parameterizing Failable
creates a new subset of Failure and the parameter passed. This allows you to
type variables that are declared using the return values of routines that can
fail.

=head1 AUTHOR

Ben Davies (Kaiepi)

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Ben Davies

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
