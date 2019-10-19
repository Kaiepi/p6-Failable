[![Build Status](https://travis-ci.org/Kaiepi/p6-Failable.svg?branch=master)](https://travis-ci.org/Kaiepi/p6-Failable)

NAME
====

Failable - Failure sum type

SYNOPSIS
========

```perl6
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
```

DESCRIPTION
===========

Failable is a class for creating Failure sum types. Parameterizing Failable creates a new subset of Failure and the parameter passed. This allows you to type variables that are declared using the return values of routines that can fail.

AUTHOR
======

Ben Davies (Kaiepi)

COPYRIGHT AND LICENSE
=====================

Copyright 2019 Ben Davies

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

