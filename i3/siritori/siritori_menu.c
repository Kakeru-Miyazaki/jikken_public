#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>

#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>
// for inet addr
// #include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <fcntl.h> // for open
#include <unistd.h> // for close
#include <time.h>

int main(int argc, char **argv){
  system("/bin/stty raw onlcr");  // enterを押さなくてもキー入力を受け付けるようになる
  printf("\r\n");

 FILE *fp = fopen("./data/menu_all.txt","r");

  if (fp == NULL){perror("cannot open the ipdata file"); exit(1);}  
  int N;
  const int MAXLEN = 30;
  fscanf(fp,"%d",&N);
  char datalist[N][MAXLEN];
  printf("  please select the menu: \r\n\r\n");
  for (int i = 0; i < N; i++){
    fscanf(fp,"%s",datalist[i]);
    if (i == 0){
        printf(" -> ");
      } else {
        printf("    ");
      }
    printf("%s\r\n",datalist[i]);
  }
  fclose(fp);


  int point = 0;
  char c;
  while((c = getchar()) != 13) {
    printf("\033[0K");

    if ((c == 'i' || c == 'A') && point > 0){
      point--;
    } else if ((c == 'm' || c == 'B') && point + 1 < N)
    {
      point++;
    }
    printf("\033[%dA" ,N);
    printf("\r");
    for (int i = 0; i < N; i++){
      if (i == point){
        printf(" -> ");
      } else {
        printf("    ");
      }
      printf("%s\r\n",datalist[i]);
    }
  }

  system("/bin/stty cooked");  // 後始末
  return point;
}
