#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char **argv){
  int n;
  unsigned int N = sizeof(short);
  int fd = open(argv[1],O_RDONLY,0644);
  if (fd == -1){perror("open"); exit(1);}
  int s = 0;
  short data;
  while (1){
    n = read(fd,&data,N);
    if (n==-1){perror("read");exit(1);}
    if (n==0) break;
    printf("%d\t%d\n",s,data);
    s += N;
  }

  close(fd);
  return 0;
}