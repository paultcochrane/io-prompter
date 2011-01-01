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
    my $stub = StubIO.new;
    
    $stub.queue-input("Hello!");
    $stub.queue-input("Look at this!");
    is $stub.get(), "Hello!", "Queued input works okay";
    is $stub.get(), "Look at this!", "Queued input works okay, part 2";
    
    $stub.print("Let's see what happens here");
    $stub.print("or here", "here", "here");
    is $stub.output[0], "Let's see what happens here", "Stored output works okay, part 1";
    is $stub.output[1], "or here", "Stored output works okay, part 2";
    is $stub.output[2], "here", "Stored output works okay, part 3";
    is $stub.output[3], "here", "Stored output works okay, part 4";
}

{
    my $stub = StubIO.new;
    
    $stub.queue-input("3");
    is prompt-conway("Weight:", :number, :in($stub), :out($stub)),
       3, "Successfully input 3";
    is $stub.output[0], "Weight: ", "Properly added space at end of prompt";

    $stub.queue-input("");
    is prompt-conway("Weight:", :number, :default(42), :in($stub), :out($stub)),
       42, "Successfully got default input";
}

{
    my $stub = StubIO.new;
    
    $stub.queue-input("3");
    is prompt-conway("Weight:", :number, :default(42), 
                                :must({'be greater than 0'=> *>0 }), 
                                :in($stub), :out($stub)),
       3, "Successfully input 3";
    is $stub.output[0], "Weight: ", "Properly added space at end of prompt";

    $stub.queue-input("");
    is prompt-conway("Weight:", :number, :default(42), 
                                :must({'be greater than 0'=> *>0 }), 
                                :in($stub), :out($stub)),
       42, "Successfully got default input";
}


done;
