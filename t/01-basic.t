use v6;
use Test;
use Failable;

plan 7;

{
    sub dk-spank-permission-check(--> Str:_) {
        fail 'Not a chance.' if state $++;
        'You may spank it... once.'
    }

    my Failable[Str:D] $failable;

    lives-ok {
        $failable = dk-spank-permission-check;
    }, "can assign a value of Failable's refinee's type to a Failable";
    isa-ok $failable, Str, "can type check Failable against its refinee's type";

    lives-ok {
        $failable = dk-spank-permission-check;
        Nil
    }, 'can assign a Failure to a Failable';
    isa-ok $failable, Failure, 'can type check Failable against Failure';
}

{
    my Failable[Mu:U] $maybe-failure  = Failure.new: 'ayy lmao';

    lives-ok {
        my Failure:D $ = $maybe-failure;
        Nil
    }, 'can assign a Failable to a variable typed as Failure:D';
}

{
    my Failable[Mu:U] $maybe-mu = Mu;

    lives-ok {
        my Mu:U $ = $maybe-mu;
    }, 'can assign a Failable to a variable typed as the refinee of the subset';
}

{
    my class Goblin { }
    my class Elf    { }

    lives-ok {
        my Failable[Junction:D] $gnome = none Goblin, Elf;
    }, 'can parameterize a Failure with a Junction and assign to it';
}

# vim: ft=perl6 ts=4 sts=4 sw=4 expandtab
