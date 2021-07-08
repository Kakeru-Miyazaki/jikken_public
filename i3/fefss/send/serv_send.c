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


#include<string.h>

int main(int argc, char **argv){
  // check error  of args
  if (argc != 2){perror("1 args reqired"); exit(1);}
  unsigned int port = 50000;
  printf("  ■■■■■■■■■■■■■■■■■■■■■■■■\n");
  printf("  ■■                    ■■\n");
  printf("  ■■    FILE SHARING    ■■\n");
  printf("  ■■                    ■■\n");
  printf("  ■■■■■■■■■■■■■■■■■■■■■■■■\n");
  printf("        Now Sending...  \n");
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
  int n;
  char buf;
  char tt = '\0';
  int length = strlen(argv[1]);
  int nn = send(s,argv[1],length,0);
  if (nn == -1){perror("send"); exit(1);}
  nn = send(s,&tt,1,0);
  if (nn == -1){perror("send");exit(1);} 
  while (1)
  {
    char c;
    int r = read(0,&c,1);
    if (r == -1){perror("read"); exit(1);}
    if (r == 0){break;}
    int n = send(s,&c,1,0);
    if (n == -1){perror("send"); exit(1);}

  }

  int check_close = close(ss);  
  if (check_close == -1){perror("cannot close"); exit(1);}
  printf(" -> Sent %s\n",argv[1]);
  return 0;


}
