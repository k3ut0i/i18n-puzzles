use strict;
use warnings;
use Encode qw(encode decode);
use List::Util qw(reduce);

sub num_char_byte{
  my $str = shift;
  my $bytes =  length($str);
  my $chars = length(decode('UTF-8', $str));
  return ($chars, $bytes);
}

sub cost{
  my ($chars, $bytes) = @_;
  my $cost = undef;
  if ($chars <= 140 and $bytes <= 160){
    $cost = 13;
  } elsif ($chars <= 140) {
    $cost = 7;
  } elsif ($bytes <= 160) {
    $cost = 11;
  } else {
    $cost = 0; # can't send it
  }
  return $cost;
}

my $total = 0;
while(<>){
  chomp;
  $total += cost(num_char_byte($_));
}
print "$total\n";


