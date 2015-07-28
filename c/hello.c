#include <stdio.h>
int main(int argc, char* argv[]) {
  printf("Hello, World!\n");
  printf("Three times 4 is %d\n: ", treble(4));
  return(0);
}

int treble(int x) {
  x *= 3;
  return(x);
}


