#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main(int argc, char **argv){
  if (argc != 3){perror("2 arguments required"); exit(-1);}
  float a = atof(argv[1]);
  if (atoi(argv[2]) < 0){perror("n should be positive integer"); exit(-1);}
  unsigned int n = atoi(argv[2]);

  const float df = pow(2,1.0/12);
  float f = 440*pow(2,-5/12);
  short buf;
  int state = 0;
  int oto = 0;
  while (oto < n){
    if (state % 12 == 1 || state % 12 == 3 || state % 12 == 6 || state % 12 == 8 || state % 12 == 10){
      
    } else {
      for (int i = 0; i < 13230 ; i++){
        buf = a*sin(2*M_PI*f*((float)i/44100));
        write(1,&buf,sizeof(short));
      }
      oto++;
    }
    f *= df;
    state ++;
  }
  return 0;
}