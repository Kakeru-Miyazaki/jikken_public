#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

int main(int argc, char **argv){
  int n;
  unsigned int N = 5;
  int fd = open(argv[1],O_RDONLY,0644);
  if (fd == -1){perror("open"); exit(1);}
  int s = 0;
  unsigned char data[N];
  while (1){
    n = read(fd,data,N);
    if (n==-1){perror("read");exit(1);}
    if (n==0) break;
    for(int i = 0 ; i < n ; i++){
      printf("%d\t%d\n",i+s,data[i]);
    }
    s += N;
  }

  close(fd);
  return 0;
}
