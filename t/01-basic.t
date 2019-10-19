use v6;
use Test;
use Failable;

plan 12;

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
    }, 'can parameterize a Failable with a Junction and assign to it';
}

{
    my class NotAnyHOW is Metamodel::ClassHOW { }

    BEGIN {
        NotAnyHOW.set_default_invoke_handler: Mu.HOW.invocation_handler: Mu;
        NotAnyHOW.set_default_parent_type: Mu;
    }

    my constant NotAny = do {
        $_ := NotAnyHOW.new_type: :name('NotAny');
        $_.^compose
    };

    is Failable[Any].^refinee, Any,
       'can type check Any against a Failable with Any';
    is Failable[Mu].^refinee, Mu,
       'can type check Mu against a Failable with Mu';
    is Failable[NotAny].^refinee, Mu,
       'can type check Mu against a Failable with any type that is not Any';
}

{
    my subset MaybeFunnyNumber of Int:_ where 68 | 419 | Nil;

    my Failable[MaybeFunnyNumber:_] $nil = Nil;
    isa-ok $nil, Failable[MaybeFunnyNumber:_],
           "can assign Nil to a Failable with a subset, returning the Failable's type object";
}

{
    lives-ok {
        my Failable[1] $one = 1;
    }, 'can use definite types with Failable';
}

# vim: ft=perl6 sw=4 ts=4 sts=4 expandtab
