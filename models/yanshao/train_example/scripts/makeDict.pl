#!/usr/bin/perl -w

while(<>) {
    chomp;
    @toks = split(/\s+/);
    foreach $t (@toks) {
        $hash{$t} = 1;
    }
}

foreach $t (keys %hash) {
    print $t."\n";
}
