#!/usr/bin/perl -w
# authors: Huihsin Tseng and Pi-Chuan Chang <pichuan@stanford.edu>
use POSIX;
use Fatal qw(open close);
use utf8;
binmode(STDIN,":utf8");
binmode(STDOUT,":utf8");
binmode(STDERR,":utf8");

while($line=<STDIN>){
    chomp $line;
    @list = split(/\t/,$line);

    die "Error: the WordPOS file has to have 2 fields per line.\n" unless $#list+1==2;

    if($list[0]=~/[A-Z]|[a-z]|[0-9]/) { next; }

    if (length($list[0]) == 1) {
        $hashi{$list[0]}=1;
    }
}

foreach $i (sort keys %hashi){
    print "$i\n";
}
