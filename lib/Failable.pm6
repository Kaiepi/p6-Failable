use v6;
unit class Failable:ver<0.0.2>:auth<github:Kaiepi>;

my Mu:U %cache{ObjAt:D};

method ^parameterize(Mu:U $, Mu:U \T --> Mu:U) {
    return %cache{T.WHICH} if %cache{T.WHICH}:exists;

    my Mu:U $failable;

    BEGIN {
        my Str:D      $name       = 'Failable[' ~ T.^name ~ ']';
        my Mu:U       $refinee    = (T ~~ Junction:_) ?? Mu:_ !! Any:_;
        my Junction:D $refinement = T | Failure:D;
        $failable := Metamodel::SubsetHOW.new_type: :$name, :$refinee, :$refinement;
        $*W.add_object_if_no_sc: $failable;
    }

    $failable
}

=begin pod

=head1 NAME

Failable - Failure sum type

=head1 SYNOPSIS

=begin code :lang<perl6>

use Failable;

sub dk-spank-permission-check(--> Str) {
    fail 'Not a chance.' if state $++;
    'You may spank it... once.'
}

my Failable[Str] $res = dk-spank-permission-check;
say $res.WHAT; # OUTPUT: Str
say $res;      # OUTPUT: You may spank it... once.

$res = dk-spank-permission-check;
say $res.WHAT;              # OUTPUT: Failure
say $res.exception.message; # OUTPUT: Not a chance.

=end code

=head1 DESCRIPTION

Failable is a class for creating Failure sum types. Parameterizing Failable
creates a new subset of Failure and the parameter passed. This allows you to
type variables that are declared using the return values of routines that can
fail.

=head1 AUTHOR

Ben Davies <Kaiepi>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Ben Davies

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
