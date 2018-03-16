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
        @list = (split/\s+/,$line);
        for($i=0; $i < $#list; $i++){
            @wp1=split(/\_/,$list[$i]);
            @wp2=split(/\_/,$list[$i+1]);
            if (length($wp1[0])==1 and length($wp2[0])==1) {
                if ($wp1[0] =~ /[\x{0020}-\x{007e}]/ or $wp2[0] =~ /[\x{0020}-\x{007e}]/) {
                    #print STDERR $wp1[0].$wp2[0]."\n";
                    next;
                }
                $hash{$wp1[0].$wp2[0]}=1;
            }
	}
    }
}

foreach $i(keys %hash){
    print "$i\n";
}
