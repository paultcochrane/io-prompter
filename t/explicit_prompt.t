#! /Users/damian/bin/rakudo*
use v6;

use Testing;
use IO::Prompter;

SKIP 'Interactive test only' if $*IN !~~ :t || $*OUT !~~ :t;

# OK have => prompt('Press "n"', :prompt("Press 'y'"), :yesno),
#    want => 1,
#    desc => "Override the prompt";
