use v6.d;
use Test;
use Failable;

plan 3;

sub dk-spank-permission-check(--> Str) {
    fail 'Not a chance.' if state $++;
    'You may spank it... once.'
}

my Failable[Str] $res = dk-spank-permission-check;
isa-ok $res, Str, 'can assign a value with the same type as the type parameter to Failable';
$res = dk-spank-permission-check;
isa-ok $res, Failure, 'can assign a Failure to a Failable';

my class Goblin { }
my class Elf    { }

lives-ok {
    my Failable[Junction] $what-am-i = none Goblin, Elf;
    $what-am-i = Failure.new: "I'm a gnome!";
}, 'can parameterize a Failure with a Junction and assign to it';

# vim: ft=perl6 ts=4 sts=4 sw=4 expandtab
