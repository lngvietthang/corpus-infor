#!/usr/bin/env perl
#===============================================================================
#
#         FILE: corpusinfor.pl
#
#        USAGE: ./corpusinfor.pl <path/to/filecorpus>
#
#  DESCRIPTION: Analyse corpus and get some information.
#               Output Information:
#                   1./ Show number of sentences
#                   2./ Show number of words
#                   3./ Show number of distinct of words
#                   4./ Show average length of a sentences
#                   5./ Show length of the longest sentence + its index
#                   6./ Show length of the shortest sentence + its index
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Viet Thang (vietthang), vietthang.hcmus@gmail.com
# ORGANIZATION: HCMC University of Science, Vietnam
#      VERSION: 1.0
#      CREATED: 06/29/2014 03:37:34 PM
#     REVISION: 0.0.1
#===============================================================================

use strict;
use warnings;
use utf8;
use Term::ANSIColor;


my $filename = $ARGV[0];
open(my $rfilehandle, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";

my $numofsents = 0;
my $numofwords = 0;
my $avernumofwordspersent = 0;
my $longestsent = 0;
my $shortestsent = 10000000;
my %htdistinctwords = ();
my $distinctwords = 0;

my $idxLS = -1;
my $idxSS = -1;
my $idx = 0;


while (my $row = <$rfilehandle>)
{
    chomp $row;
    $numofsents += 1;
    my @words = split(' ', $row);

    my $size = @words;

    if ($size > $longestsent)
    {
        $longestsent = $size;
        $idxLS = $idx;
    }
    if ($size < $shortestsent)
    {
        $shortestsent = $size;
        $idxSS = $idx;
    }

    $numofwords += $size;
    $idx++;
    foreach my $word (@words)
    {
        #print "$word\n";
        if (exists($htdistinctwords{$word}))
        {
            $htdistinctwords{$word}++;
        }
        else
        {
            $htdistinctwords{$word} = 1;
        }
    }
}

$avernumofwordspersent = $numofwords / $numofsents;
my @keys = keys %htdistinctwords;
$distinctwords = @keys;

print color("blue"), "Number of sentences -> '$numofsents'\n";
print "Number of words -> '$numofwords'\n";
print "Number of distinct words -> '$distinctwords'\n";
print "Average length of a sentence -> '$avernumofwordspersent'\n";
print "Length of the longest sentence -> '$idxLS' -> '$longestsent'\n";
print "Length of the shortest sentence -> '$idxSS' -> '$shortestsent'\n", color("reset");

#my @words = split(' ', $row);

#foreach my $word (@words)
#{
#    print "$word\n";
#}
