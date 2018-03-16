#!/usr/bin/perl -w

$CTB6POS = "$ARGV[0]/data/utf8/postagged/";

while(<STDIN>) {
    s/^\s+//;
    s/\s+$//;
    s/\.fid$//;
    $_ .= ".pos";
    $cmd = "cat $CTB6POS/$_";
    system($cmd);
}
