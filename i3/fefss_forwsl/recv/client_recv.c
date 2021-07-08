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

int main(int argc, char **argv){

 FILE *fp = fopen("/home/kakeru/fefss/data/ipdata.txt","r");
  if (fp == NULL){perror("cannot open the ipdata file"); exit(1);}  
  int N;
  const int MAXLEN = 30;
  fscanf(fp,"%d",&N);
  char datalist[N][2][MAXLEN];
  for (int i = 0; i < N; i++){
    fscanf(fp,"%s%s",datalist[i][0],datalist[i][1]);
    printf(" %2d %s %s\n",i,datalist[i][0],datalist[i][1]);
  }
  fclose(fp);

  printf("\n");
  printf("please select the number of sender: ");
  int datanum;
  if (fscanf(stdin,"%d",&datanum) == -1){perror("your input was illegal"); exit(1);}
  
  printf("  ■■■■■■■■■■■■■■■■■■■■■■■■\n");
  printf("  ■■                    ■■\n");
  printf("  ■■    FILE SHARING    ■■\n");
  printf("  ■■                    ■■\n");
  printf("  ■■■■■■■■■■■■■■■■■■■■■■■■\n");
  printf("       Now Receiving... \n");

  char *ip = datalist[datanum][1];
  unsigned int port = 50000;
  
  int s = socket(PF_INET, SOCK_STREAM, 0);
  if (s == -1){perror("socket"); exit(1);}
  
  struct sockaddr_in addr;
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = inet_addr(ip);
  // -1 でerrorとると Use of this function is problematic because -1 is a valid address (255.255.255.255). 
  addr.sin_family = AF_INET;
  addr.sin_port = htons(port);
  int ret = connect(s, (struct sockaddr *)&addr,sizeof(addr));
  if (ret == -1){perror("cannot connect"); exit(1);}  

  int n;
  char buf;
  char filename[MAXLEN];
  for (int i = 0; i < MAXLEN; i++){
    // filename[i] = NULL;
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
  printf(" -> Received %s\n",filename);
  return 0;
}
