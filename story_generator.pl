#!/usr/bin/perl
use strict;
use warnings;

my @story_template = <STDIN>;

my $location_pattern = qr/(\{([^\}]+)\})/;
my @location;
my $thing_pattern = qr/(\[([^\]]+)\])/;
my @thing;
my $person_pattern = qr/(\(([^\)]+)\))/;
my @person;
my $action_pattern = qr/(\<([^\>]+)\>)/;
my @action;

# Make a list of locations, things and persons
my ( %location, %thing, %person, %action );
foreach my $template_line (@story_template) {
    while ( $template_line =~ /$location_pattern/g ) {
        $location{$2}++;
    }
    while ( $template_line =~ /$thing_pattern/g ) {
        $thing{$2}++;
    }
    while ( $template_line =~ /$person_pattern/g ) {
        $person{$2}++;
    }
    while ( $template_line =~ /$action_pattern/g ) {
        $action{$2}++;
    }

}
push @location, $_ foreach keys %location;
push @thing,    $_ foreach keys %thing;
push @person,   $_ foreach keys %person;
push @action,   $_ foreach keys %action;

# Get random location, thing and person
my $random_location = $location[ int( rand( scalar @location ) ) ];
my $random_thing    = $thing[ int( rand( scalar @thing ) ) ];
my $random_person   = $person[ int( rand( scalar @person ) ) ];
my $random_action   = $action[ int( rand( scalar @action ) ) ];

# print $story_template[0];    # debug
# print $story_template[1];    # debug

# int(rand(10))

my $story_line = $story_template[ int( rand( scalar @story_template ) ) ];

while ( $story_line =~ /$location_pattern/ ) {
    my $random_location = $location[ int( rand( scalar @location ) ) ];
    $story_line =~ s/$location_pattern/$random_location/;
}
while ( $story_line =~ /$thing_pattern/ ) {
    my $random_thing = $thing[ int( rand( scalar @thing ) ) ];
    $story_line =~ s/$thing_pattern/$random_thing/;
}
while ( $story_line =~ /$person_pattern/ ) {
    my $random_person = $person[ int( rand( scalar @person ) ) ];
    $story_line =~ s/$person_pattern/$random_person/;
}
while ( $story_line =~ /$action_pattern/ ) {
    my $random_action = $action[ int( rand( scalar @action ) ) ];
    $story_line =~ s/$action_pattern/$random_action/;
}

print $story_line;
