#include <stdio.h>
#include <stdlib.h>

#include <math.h>
int main(int argc, char **argv){
  if (argc != 4){perror("3 arguments required"); exit(-1);}
  float a = atof(argv[1]);
  float f = atof(argv[2]);
  if (atoi(argv[3]) < 0){perror("n should be positive integer"); exit(-1);}
  unsigned int n = atoi(argv[3]);
  short buf;
  for (int i = 0; i < n ; i++){
    buf = a*sin(2*M_PI*f*((float)i/44100));
    write(1,&buf,sizeof(short));
  }
  return 0;
}
