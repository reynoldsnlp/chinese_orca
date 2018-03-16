#!/usr/bin/perl -w
# authors: Huihsin Tseng and Pi-Chuan Chang <pichuan@stanford.edu>

use POSIX;
use Fatal qw(open close);
use utf8;
binmode(STDIN,":utf8");
binmode(STDOUT,":utf8");
binmode(STDERR,":utf8");

$CTB6POS = "$ARGV[0]/data/utf8/segmented/";

while(<STDIN>) {
    s/^\s+//;
    s/\s+$//;
    s/\.fid$//;
    $_ .= ".seg";
    $file = "$CTB6POS/$_";
    die "can't open file $file\n" unless open (FP,$file);
    binmode(FP,":utf8");
    while($line=<FP>){
        $line =~ s/^\s+//;
        $line =~ s/\s+$//;
        if(not ($line =~ /^</ and $line =~ />$/)){
            print $line."\n";
        }
    }
}
