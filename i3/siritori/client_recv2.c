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

int hantei(int a,int b){
  return (a != b)?-1:0;
}

int main(int argc, char **argv){
  if (argc != 3){perror("2 args reqired"); exit(1);}
  char *ip = argv[1];
  unsigned int port = atoi(argv[2]);
  
  int s = socket(PF_INET, SOCK_STREAM, 0);
  if (s == -1){perror("socket"); exit(1);}
  
  struct sockaddr_in addr;
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = inet_addr(ip);
  addr.sin_family = AF_INET;
  addr.sin_port = htons(port);
  int ret = connect(s, (struct sockaddr *)&addr,sizeof(addr));
  if (ret == -1){perror("cannot connect"); exit(1);}  

  const unsigned int maxlen = 256;
  int n;
  char buf;
  char c;
  int r;
  char before;
  char head;
  int flag = 0;
    char sendmsg[]="You Win!\n";
    char selfmsg[]="You Lose...\n";
  while(1){
    
  while (1){
    n = recv(s, &buf,1 ,0);
    if (n == 0)break;
    if (buf == ' ')break;
    if (buf == 'Y'){
      while(1){
      n = recv(s, &buf,1 ,0);
      if(n == 0)break;
      if(buf == '\n')break;
      }
      goto end;
    }
    before=buf;
    printf("\033[36m%c",buf);
  }
  printf("\n\033[39m  meaning: ");
  while (1){
    n = recv(s, &buf,1 ,0);
    if (n == 0)break;
    if (buf == '\n')break;
    printf("%c",buf);
  }

  
    printf("\n\n\033[33mYour turn. Initial \"%c\"\033[39m\n",before);
    r = read(0,&c,1);
    if (r == -1){perror("read"); exit(1);}
    head = c;
    flag = hantei(before,head);
  if (flag == -1){
    n = send(s,&sendmsg,sizeof(sendmsg),0);
    if (n == -1){perror("send"); exit(1);}
    while(getchar()!='\n');
    printf("You Lose...\n");
    return 0;
  }
    n = send(s,&c,1,0);
    if (r == 0 || c=='\n'){break;}
    if (n == -1){perror("send"); exit(1);}
  
  


  while(1){
    r = read(0,&c,1);
    if (r == -1){perror("read"); exit(1);}
    if ((c < 'a' || 'z' < c )&& c!='\n')continue;
    n = send(s,&c,1,0);
    if (r == 0 || c=='\n'){break;}
    if (n == -1){perror("send"); exit(1);}
  }
  }

  end:
  printf("You Win!");
  close(s);
  return 0;
}
