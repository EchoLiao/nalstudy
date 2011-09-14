
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <setjmp.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <netinet/in.h>
#include <arpa/inet.h>



#define TDDebug(...)    do { \
    fprintf(stdout, __VA_ARGS__); \
    printf("\n"); \
} while ( 0 )

#define BUFFER_LEN 1024
#define MCAST_PORT 2008

int main(int argc, char **argv)
{
    int hUDPCmdSocket = -1;
    struct sockaddr_in myaddr;
    struct sockaddr_in mUDPCmdAddr;
    unsigned int socklen;
    char strTmpIP[16] = "232.0.0.105" ;
    char m_szMyIP[16] = "192.168.3.101";

    if ( argc < 2 ) 
    {
        printf("Usage: %s LOCAL_IP\n", argv[0]);
        exit(1);
    }

    strcpy(m_szMyIP, argv[1]);

    TDDebug("NNNNNNNNNNN");
    TDDebug(strTmpIP);
    TDDebug(m_szMyIP);

    hUDPCmdSocket = socket(AF_INET, SOCK_DGRAM, 0);
    if (hUDPCmdSocket < 0)
    {
        TDDebug("socket creating error\n");
        exit(1);
    }
    int yes = 1;
    if (setsockopt(hUDPCmdSocket, SOL_SOCKET, SO_REUSEADDR,
                (char *) &yes, sizeof(yes)) == -1) 
    {
        TDDebug("setsockopt error 1a\n");
        close(hUDPCmdSocket);
        return -1;
    }
    socklen = sizeof(struct sockaddr_in);
    memset(&mUDPCmdAddr, 0, socklen);
    mUDPCmdAddr.sin_family = AF_INET;
    mUDPCmdAddr.sin_port = htons(MCAST_PORT);
    if (inet_pton(AF_INET, strTmpIP, &mUDPCmdAddr.sin_addr) <= 0)
    {
        TDDebug("wrong group address!\n");
        exit(0);
    }
    memset(&myaddr, 0, socklen);
    myaddr.sin_family = AF_INET;
    myaddr.sin_port = htons(2009);
    if (inet_pton(AF_INET, m_szMyIP, &myaddr.sin_addr) <= 0)
    {
        TDDebug("self ip address error!\n");
        exit(0);
    }
    if (bind(hUDPCmdSocket, (struct sockaddr *) &myaddr,
                sizeof(struct sockaddr_in)) == -1)
    {
        TDDebug("Bind error\n");
        exit(0);
    }
    TDDebug("create socket ok \n");


    int cou = 0;
    while ( 1 )
    {
        TDDebug("send to stb begin\r");
        char service[BUFFER_LEN] = { 0 };
        sprintf(service, "%s %d\n", "STBCMD:test! send!", ++cou);
        if ( sendto(hUDPCmdSocket, service, strlen(service) + 1, 0,
                    (struct sockaddr *)&mUDPCmdAddr, sizeof(struct sockaddr_in)) < 0 )
        {
            TDDebug("Send service's data error...\n");
        }
        TDDebug("send to stb end\r\n");
        usleep(2000 * 1000);
    }

    return 0;
}

