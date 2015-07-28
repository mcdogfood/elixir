use strict;
use warnings;
use Data::Dumper;

# Recursion
# Binary representation of any number is 2k + b where k is a smaller 
# whole number, and b is either 0 or 1
sub binary {
  my ($n) = @_;                       # copy passed argument to $n
  return $n if $n == 0 || $n == 1;    # stop if $n is 0 or 1
  my $k = int($n/2);                  # divide $n by 2 and assign to $k
  my $b = $n % 2;                     # get remainder from dividing $n by 2 and assign to $b
  my $E = binary($k);                 # Recurse using $k as argument
  return $E . $b;                     # return the binary string
}
print "Binary representation of 37 is " . binary(37) . "\n";

# Factorial is a classic recursion problem - basically - all the numbers multiplied
# by all the ones that are lower than that
sub factorial {
  my ($n) = @_;
  return 1 if $n == 0;
  return factorial($n-1) * $n;
}


###
### hanoi
###

## Chapter 1 section 3

# hanoi(N, start, end, extra)
# Solve Tower of Hanoi problem for a tower of N disks,
# of which the largest is disk #N.  Move the entire tower from
# peg `start' to peg `end', using peg `extra' as a work space
  
sub hanoi {
  my ($n, $start, $end, $extra) = @_;
  die "not enough arguments" if @_ != 4;
  if ($n == 1) { 
    print "Move disk #1 from $start to $end.\n";  # Step 1
  } 
  else {
    hanoi($n-1, $start, $extra, $end);            # Step 2
    print "Move disk #$n from $start to $end.\n"; # Step 3
    hanoi($n-1, $extra, $end, $start);            # Step 4
  }
}
#hanoi(6, 'A', 'C', 'B');

# This version accepts a fifth parameter, a subroutine reference
# so that we can control the behaviour of what we want the display to
# actually do, so it could update a graphical display, print some text
# or JSON it somewhere!
sub hanoi2 {
  my ($n, $start, $end, $extra, $move_disk) = @_;
  die "not enough arguments: " . scalar (@_) if @_ != 5;
  if ($n == 1) { 
    $move_disk->(1, $start, $end);                    # Step 1
  } 
  else {
    hanoi2($n-1, $start, $extra, $end, $move_disk);   # Step 2
    $move_disk->($n,$start,$end);                     # Step 3
    hanoi2($n-1, $extra, $end, $start, $move_disk);   # Step 4
  }
}
# This is the 'callback' function - because it is passed to the routine
# and 'called back' by the main routine.
my $print_instruction = sub {
  my ($disk, $start, $end) = @_;
  print "Move disk #$disk from $start to $end.\n";
};

# Call the routine.
# hanoi2(3, 'A', 'C', 'B', $print_instruction);

###
### check_move - this is a function we can pass into hanoi instead
### of the print_instruction - this checks the move isn't going to
### do anything illegal and then carries on as before
# The purpose of doing things things this way is to enable expansion
# of an existing routine - if we think this routine might want to do
# something else, we can expand it easily without cluttering up the main code.
###

## Chapter 1 section 3

# Interesting way of assigning an array to be all of the same value
my @position = (' ', ('A') x 3); # Disks are all initially on peg A

sub check_move {
  my $i;
  my ($disk, $start, $end) = @_;
  if ($disk < 1 || $disk > $#position) {
    die "Bad disk number $disk. Should be 1..$#position.\n";
  }
  unless ($position[$disk] eq $start) {
    die "Tried to move disk $disk from $start, but it is on peg $position[$disk].\n";
  }
  for $i (1 .. $disk-1) {
    if ($position[$i] eq $start) {
      die "Can't move disk $disk from $start because $i is on top of it.\n";
    } elsif ($position[$i] eq $end) {
      die "Can't move disk $disk to $end because $i is already there.\n";
    }
  }
  print "Moving disk $disk from $start to $end.\n";
  $position[$disk] = $end;
}

#hanoi2(3, 'A', 'C', 'B', \&check_move);

###
### total_size_broken
### basically, broken because the directory handle is global

## Chapter 1 section 4

sub total_size_broken {
  my ($top) = @_;
  my $total = -s $top;
  return $total if -f $top;
  unless (opendir DIR, $top) {
    warn "Couldn't open directory $top: $!; skipping.\n";
    return $total;
  }
  my $file;
  while ($file = readdir DIR) {
    next if $file eq '.' || $file eq '..';
    $total += total_size_broken("$top/$file");
  }
  closedir DIR;
  return $total;
}

###
### total_size
###

## Chapter 1 section 4

sub total_size {
  my ($top) = @_;
  my $total = -s $top;
  my $DIR;

  return $total if -f $top;
  unless (opendir $DIR, $top) {
    warn "Couldn't open directory $top: $!; skipping.\n";
    return $total;
  }

  my $file;
  while ($file = readdir $DIR) {
    next if $file eq '.' || $file eq '..';
    $total += total_size("$top/$file");
  }          
  
  closedir $DIR;
  return $total;
}

#print total_size('Chap1') . "\n";
#print total_size('Chap2');

###
### dir_walk_simple
###

## Chapter 1 section 5

sub dir_walk_simple {
  my ($top, $code) = @_; # I prefer shift here for clarity, but
  # $top is the directory we're starting from
  # $code is what we want to do with things when we find them.
  my $DIR;
  
  $code->($top);
  
  if (-d $top) {
    my $file;
    unless (opendir $DIR, $top) {
      warn "Couldn't open directory $top: $!; skipping.\n";
      return;
    }
    while ($file = readdir $DIR) {
      next if $file eq '.' || $file eq '..';
      dir_walk_simple("$top/$file", $code);
    }
  }
}
# example usage of dir_walk_simple
# sub print_dir {
#   print $_[0], "\n";
# }
# dir_walk_simple('.', \&print_dir );

# Same function, but now it prints out the sizes as well
#dir_walk_simple('.', sub { printf "%6d %s\n", -s $_[0], $_[0] } );

###
### dir_walk_callbacks
###

## Chapter 1 section 5

sub dir_walk_callbacks {
  my ($top, $filefunc, $dirfunc) = @_;
  my $DIR;

  if (-d $top) {
    my $file;
    unless (opendir $DIR, $top) {
      warn "Couldn't open directory $top: $!; skipping.\n";
      return;
    }

    my @results;
    while ($file = readdir $DIR) {
      next if $file eq '.' || $file eq '..';
      push @results, dir_walk_callbacks("$top/$file", $filefunc, $dirfunc);
    }
    return $dirfunc->($top, @results);
  } else {
    return $filefunc->($top);
  }
}

sub file_size { -s $_[0] }
sub dir_size {
  my $dir = shift;
  my $total = -s $dir;
  my $n;
  for $n (@_) { $total += $n }
  return $total;
}

my $total_size = dir_walk_callbacks('.', \&file_size, \&dir_size);
print "Total size of current directory is $total_size\n";

# Iterators

sub upto {
  my ($m, $n) = @_;
  return sub {
    return $m <= $n ? $m++ : undef;
  };
}

my $it = upto(3,5);

while (defined(my $val = $it->())) {
  #print "$val\n";
}
