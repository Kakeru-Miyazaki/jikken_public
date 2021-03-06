#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>

#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <fcntl.h> // for open
#include <unistd.h> // for close
#include <time.h>

int main(int argc, char **argv){
  system("/bin/stty raw onlcr");  // enterを押さなくてもキー入力を受け付けるようになる
  printf("\r\n");

 FILE *fp = fopen("/home/kakeru/fefss/data/ipdata.txt","r");
  if (fp == NULL){perror("cannot open the ipdata file"); exit(1);}  
  int N;
  const int MAXLEN = 30;
  fscanf(fp,"%d",&N);
  char datalist[N][2][MAXLEN];
  printf("  please select the sender: \r\n\r\n");
  for (int i = 0; i < N; i++){
    fscanf(fp,"%s%s",datalist[i][0],datalist[i][1]);
    if (i == 0){
        printf(" -> ");
      } else {
        printf("    ");
      }
    printf("%s\r\n",datalist[i][0]);
  }
  fclose(fp);


  int point = 0;
  char c;
  while((c = getchar()) != 13) {
    printf("\033[0K");

    // printf("%d",c);
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
      printf("%s\r\n",datalist[i][0]);
    }
  }

  int datanum = point;
  

  printf("\r\n");
  printf("\r\n");
  printf("\033[0K");
  printf(" >>>>> Now Receiving... <<<<< \r\n\r\n");

  char *ip = datalist[datanum][1];
  unsigned int port = 50000;
  
  int s = socket(PF_INET, SOCK_STREAM, 0);
  if (s == -1){perror("socket"); exit(1);}
  
  struct sockaddr_in addr;
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = inet_addr(ip);
  addr.sin_family = AF_INET;
  addr.sin_port = htons(port);
  int ret = connect(s, (struct sockaddr *)&addr,sizeof(addr));
  if (ret == -1){system("/bin/stty cooked");perror("cannot connect"); exit(1);}  

  int n;
  char buf;
  char filename[MAXLEN];
  for (int i = 0; i < MAXLEN; i++){
    filename[i] = '\0';
  }
  for (int i = 0; i < MAXLEN; i++){
    n = recv(s, &buf,1 ,0);
    if (n == 0 || buf == EOF)break;
    if (buf == '\0'){
      break;
    } else {
      filename[i] = buf;
    }
  }
  
  FILE *of = fopen(filename,"w");
  int buf2;
  while (1){
    n = recv(s, &buf2,1 ,0);
    if (n == 0 || buf2 == EOF)break;
    fprintf(of,"%c",buf2);
  }
  FILE * tmpname = fopen("tmpnameforfefss.txt","w");
  fprintf(tmpname,"%s",filename);
  close(s);
  printf("\r\n");

  printf(" -> Received %s\r\n",filename);
  system("/bin/stty cooked");  // 後始末
  return 0;
}
