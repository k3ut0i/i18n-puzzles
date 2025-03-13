use strict;
use warnings;
use DateTime;
use DateTime::Format::Strptime;

my $strp = DateTime::Format::Strptime->new( pattern => "%Y-%m-%dT%T%z",
                                            on_error=> 'croak');

sub to_epoch{
  my $timestr = shift;
  my $time = $strp->parse_datetime($timestr);
  return $time->epoch;
}

sub read_times{
  my %times;
  while (<>) {
    chomp;
    my $sec =  to_epoch($_);
    $times{$sec} = defined $times{$sec} ? (1+$times{$sec}) : 1;
  }
  return %times;
}

sub find_time{
  my %times = read_times();
  foreach my $sec (keys %times) {
    if ($times{$sec} >= 4){
      return DateTime->from_epoch(epoch => $sec);
    }
  }
}

# I just added the gmt timezone manually.
# formatter could also be set, but I couldn't be bothered
print find_time(), "+00:00\n";
