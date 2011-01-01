#! /Users/damian/bin/rakudo'
use v6;

use IO::Prompter;

loop {
    my $name    = prompt-conway("Name:")            // last;
    my $age     = prompt-conway("Age:", :integer, :must({'be positive'=>*>0}) )
                                             // last;
    my $married = prompt-conway("Married?", :yesno) // last;

    report($name, $age, $married);
}





















sub report ($name, $age, $married) {
    say "    $name (aged $age) is{$married ?? '' !! "n\'t"} married";
}

