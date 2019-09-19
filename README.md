[![Build Status](https://travis-ci.org/Kaiepi/p6-Failable.svg?branch=master)](https://travis-ci.org/Kaiepi/p6-Failable)

NAME
====

Failable - Failure sum type

SYNOPSIS
========

```perl6
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

