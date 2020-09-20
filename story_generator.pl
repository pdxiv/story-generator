#!/usr/bin/perl
use strict;
use warnings;

my @story_template = <STDIN>;

# We're using a dynamic tagging pattern. Something like: <person:Bob>.
my $tagging_pattern = qr/<(\w+):([^>]*)>/;

# Generate statistics over tags
my %tag_stats;
foreach my $template_line (@story_template) {
    while ( $template_line =~ /$tagging_pattern/g ) {
        $tag_stats{$1}{$2}++;
    }
}

my %tagged_phrase_list;
foreach my $tag ( sort keys %tag_stats ) {
    foreach my $phrase ( sort keys %{ $tag_stats{$tag} } ) {
        push @{ $tagged_phrase_list{$tag} }, $phrase;
        # print "DEBUG: $tag: $phrase\n";
    }
}

my $story_line = $story_template[ int( rand( scalar @story_template ) ) ];

while ( $story_line =~ /$tagging_pattern/ ) {    
    my $random_phrase = random_phrase_by_tag($1);
    $story_line =~ s/$tagging_pattern/$random_phrase/;
}

chomp $story_line;
print "$story_line\n";

sub random_phrase_by_tag {
    my $tag         = shift;
    my @phrase_list = @{ $tagged_phrase_list{$tag} };
    my $phrase      = $phrase_list[ int( rand( scalar @phrase_list ) ) ];
    return $phrase;
}
