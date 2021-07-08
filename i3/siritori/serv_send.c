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
  // check error  of args
  if (argc != 2){perror("1 args reqired"); exit(1);}
  unsigned int port = atoi(argv[1]);
  
  // creating socket
  int ss = socket(PF_INET, SOCK_STREAM, 0);
  if (ss == -1){perror("socket"); exit(1);}

  // settings (text p.181)
  struct sockaddr_in addr;
  addr.sin_family = AF_INET;
  addr.sin_port = htons(port); // port is argv[1]
  addr.sin_addr.s_addr = INADDR_ANY;
  
  // bind
  bind(ss,(struct sockaddr *) & addr, sizeof(addr));

  // listen
  listen(ss, 10); // 10 is max number of access

  // accept
  struct sockaddr_in client_addr;
  socklen_t len = sizeof(struct sockaddr_in);
  int s = accept(ss, (struct sockaddr *)&client_addr,&len);
  if (s == -1){perror("error cannot accept"); exit(1);}
    // if s is  not -1 (error), it is the new socket to send/recv the client

  // main part
  
  const unsigned int maxlen = 256;
  int n;
  char buf;
  char c;
  char before = 'c';
  int r;  
  int flag=0;
  int head;
  // changed below part
    char sendmsg[]="You Win!\n";
    char selfmsg[]="You Lose...\n";

  while (1)
  {
    // while (getchar() != '\n');
    
    printf("\n\033[33mYour turn. Initial %c\033[39m\n",before);
    printf(" >> ");
    r = read(0,&c,1);
    if (r == -1){perror("read"); exit(1);}
    head = c;
    flag = hantei(before,head);

    if (flag == -1){
    n = send(s,&sendmsg,sizeof(sendmsg),0);
    if (n == -1){perror("send"); exit(1);}
    while(getchar()!='\n');
    printf("You Lose...");
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
    while(1){
    n = recv(s, &buf,1 ,0);
    if(n == 0)break;
    if(buf == '\n')break;
    if (buf == 'Y'){
      while(1){
      n = recv(s, &buf,1 ,0);
      if(n == 0)break;
      if(buf == '\n')break;
      }
      goto end;
    }
    before = buf;
    printf("%c",buf);
    }
  }

  int check_close = close(ss);  
  end:
  printf("You Win!\n");
  if (check_close == -1){perror("cannot close"); exit(1);}
  return 0;

}
