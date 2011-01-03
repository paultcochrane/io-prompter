use v6;
use Test;
use IO::Prompter;

class StubIO is IO {
    has @.input handles (:push<push>, :get<shift>, :queue-input<push>);
    has @.output handles (:print<push>);
    multi method t() { Bool::True; }
}

plan *;

{
    my $stub = StubIO.new(:input("10", "20", "fdfd", "40"));

    my @results;
    prompt :in($stub), :out($stub), -> Str $i {
        isa_ok $i, Str, "Block gets Str as specified";
        @results.push($i);
    };
    
    is ~@results, ~(10, 20, "fdfd", 40), "Got the correct results";
}

{
    my $stub = StubIO.new(:input("10", "20", "fdfd", "40"));

    my @results;
    prompt :in($stub), :out($stub), -> Int $i {
        isa_ok $i, Int, "Block gets Int as specified";
        @results.push($i);
    };
    
    is ~@results, ~(10, 20, 40), "Got the correct results";
}

{
    my $stub = StubIO.new(:input("10", "20.2", "fdfd", "40e20"));

    my @results;
    prompt :in($stub), :out($stub), -> Num $i {
        isa_ok $i, Num, "Block gets Num as specified";
        @results.push($i);
    };
    
    is ~@results, ~(10, 20.2, 40e20), "Got the correct results";
}

{
    my $stub = StubIO.new(:input("yes", "no", "green", "no", "yes"));

    my @results;
    prompt :in($stub), :out($stub), -> Bool $i {
        isa_ok $i, Bool, "Block gets Bool as specified";
        @results.push($i);
    };
    
    is ~@results, ~(Bool::True, Bool::False, Bool::False, Bool::True), "Got the correct results";
}



done;