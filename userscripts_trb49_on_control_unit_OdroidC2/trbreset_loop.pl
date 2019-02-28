#!/usr/bin/perl

use strict; 
use warnings;

### Change THIS! endpoint == FPGA; (1 TRB = 5 FPGAs) -> JPS
my $required_endpoints = 5;

my $max_counter = 10;
my $counter = 0;
my $number = 0;


#js while (($number != 65) || ($counter > $max_counter)) {
#while (($number < $required_endpoints) || ($counter > $max_counter)) {
while (($number < $required_endpoints) ) {
    my $c; my $res;

    $counter++;
    $c= "/home/odroid/trbsoft/trbnettools/bin/trbcmd reset"; 
   # $c= "trbcmd reset";
    $res = qx($c);
    
    $c = "/home/odroid/trbsoft/trbnettools/bin/trbcmd i 0xffff | wc -l";
   # $c = "trbcmd i 0xffff | wc -l";
    $res = qx($c),
    print "- number of trb endpoints in the system: $res";
    ($number) = $res =~ /(\d+)/;
    print "number of enpoints is not equal to the required enpoints $required_endpoints, so try next reset!\n" if ($number !=$required_endpoints);
}
