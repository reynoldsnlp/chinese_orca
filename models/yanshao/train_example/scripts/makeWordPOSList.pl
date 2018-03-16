#!/usr/bin/perl -w
# authors: Huihsin Tseng and Pi-Chuan Chang <pichuan@stanford.edu>

use POSIX;
use Fatal qw(open close);
use utf8;
binmode(STDIN,":utf8");
binmode(STDOUT,":utf8");
binmode(STDERR,":utf8");

while($line=<STDIN>){
    $line =~ s/^\s+//;
    $line =~ s/\s+$//;
    if(not ($line =~ /^</ and $line =~ />$/)){
	@list=split/\s+/,$line;
	foreach $i (@list){
            $hash{$i}=1;
	}
    }
}

foreach $i(sort keys %hash){
    $i=~s/\_/\t/;
    @toks = split(/\t/,$i);
    die "toks=".join(" ",@toks)."\n" if $#toks+1 != 2;
    print "$i\n";
}
