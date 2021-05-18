#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char **argv){
  int n;
  if (argc != 2 || atoi(argv[1]) < 0){perror("1 positive integer required"); exit(1);}
  int k = atoi(argv[1]);
  const int N = sizeof(short);
  //int fd = open(argv[1],O_RDONLY,0644);
  //if (fd == -1){perror("open"); exit(1);}
  
  int s = 0;
  short data;

  while (1){
    n = read(0,&data,N);
    if (n==-1){perror("read");exit(1);}
    if (n==0) break;
    //printf("%d\t%d\n",s,data);
    //s += N;
    if (s % k == 0){
      write(1,&data,N);
    }
    s++;
  }

  return 0;
}