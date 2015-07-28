#include <stdio.h>
int main(int argc, char* argv[]) {
  char *names[] = {"Miller", "Jones", "Anderson"};
  printf("%c\n", *(*(names+1)+2));  // This is a kind of double de-referencing
  printf("%c\n", names[1][2]); // Uses array notation to access the character 'n' from the 
                               // names Jones above - easier to read than above
  
  const int *pci;   //pci is a pointer variable to a constant integer - read backwards
  int num = 0;
  int *pi = &num;
 
  // These produce compiler warnings on Nitrous, but they don't on my own machine. 
  printf("Address of num: %d Value: %d\n", &num, num);
  printf("Address of pi: %d Value: %d\n", &pi, pi);
  return(0);
}

