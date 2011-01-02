#! /Users/damian/bin/rakudo*
use v6;

use Testing;
use IO::Prompter;

SKIP 'Interactive test only' if $*IN !~~ :t || $*OUT !~~ :t;

OK have => prompt(:wf, :yn, 'This should have wiped the screen. Did it?'),
   desc => "Wipe first";

OK have => prompt(:wf, :yn, 'This should not have wiped the screen. Did it?'),
   want => 0,
   desc => "Wipe first";

OK have => prompt(:w, :yn, 'This should have wiped the screen. Did it?'),
   desc => "Wipe first";
