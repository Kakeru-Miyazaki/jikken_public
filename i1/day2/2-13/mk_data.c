#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char **argv){
  int N = 25600;
  int fd = open(argv[1],O_WRONLY|O_CREAT|O_TRUNC,0644);
  unsigned char data[N];
  for (int i = 0; i < N ; i++){
    data[i] = (i / 100)*10;
  }
  write(fd,data,N);
  close(fd);
  return 0;
}