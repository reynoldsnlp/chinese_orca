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

    @array = split(//, $list[0]);
    for($i=0; $i<$#array+1; $i++) {
        $c = $array[$i];
        $hash{$list[1]."\t".$c} = 1;
        if ($i==0) { $hashp{$list[1]."p\t".$c} = 1; }
        elsif ($i==$#array) { $hashs{$list[1]."s\t".$c} = 1; }
        else { $hashi{$list[1]."i\t".$c} = 1; } 
    }
}


foreach $i (sort keys %hash){
    print  "$i\n";
}

foreach $i (sort keys %hashp){
    print  "$i\n";
}

foreach $i (sort keys %hashs){
    print  "$i\n";
}

foreach $i (sort keys %hashi){
    print  "$i\n";
}
