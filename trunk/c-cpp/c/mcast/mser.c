
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
#include <netinet/in.h>	/* sockaddr_in{} and other Internet defns */
#include <arpa/inet.h>



#define TDDebug(...)    do { \
    fprintf(stdout, __VA_ARGS__); \
    printf("\n"); \
} while ( 0 )

#define BUFFER_LEN 1024
#define MCAST_PORT 2008

int main(int argc, char **argv)
{
    int mc;
    char    buffer[BUFFER_LEN];
    int	nRet = 0;
    socklen_t fromlen;
    struct sockaddr_in local, from;
    // struct timeval time_out;
    char strTmpIP[16] = "232.0.0.101";
    char gzMyIP[16] = "192.168.3.101";
    struct ip_mreq UDPCmdipmr;

    if ( argc < 2 ) 
    {
        printf("Usage: %s LOCAL_IP\n", argv[0]);
        exit(1);
    }

    strcpy(gzMyIP, argv[1]);

    TDDebug("UDP hello mc is s");
    TDDebug("strTmpIP=%s gzMyIP=%s", strTmpIP, gzMyIP);

    mc = socket(AF_INET, SOCK_DGRAM, 0);
    if (mc <=  0)
    {
        TDDebug("UDP hello mc is error");
        return 0;
    }
    local.sin_family = AF_INET;
    local.sin_addr.s_addr=htonl (INADDR_ANY);
    local.sin_port = htons(MCAST_PORT);
    UDPCmdipmr.imr_multiaddr.s_addr = inet_addr(strTmpIP);
    UDPCmdipmr.imr_interface.s_addr = inet_addr(gzMyIP);
    if(bind(mc, (struct sockaddr *)&local, sizeof(local)) != 0)
    {
        TDDebug("UDP hello bind is error");
        return 0;
    }
    TDDebug("UDP hello mc is 3s");
    if(setsockopt(mc,IPPROTO_IP, IP_ADD_MEMBERSHIP,(char *)&UDPCmdipmr, sizeof(UDPCmdipmr))== -1)
    {
        TDDebug("UDP hello setsockopt is error");
        return 0;
    }
    int nLoop = 0;
    if (setsockopt (mc, IPPROTO_IP, IP_MULTICAST_LOOP, (char *)&nLoop, sizeof(int)) == -1)
    {
        return 0;
    }
    while(1)
    {
        TDDebug("NAL &&&&&&&&&&&&& mc1\n");
        memset(buffer,0,sizeof(buffer));
        nRet = recvfrom(mc, buffer, BUFFER_LEN - 1, 0, (struct sockaddr *)&from, &fromlen);
        if(nRet == 0)
        {
            TDDebug("UDP hello time out");
        }
        else if(nRet == -1)
        {
            TDDebug("UDP hello socket error");
        }
        else
        {
            buffer[nRet] = 0;
            TDDebug(buffer);
            if(strncmp(buffer,"STBCMD:",7) != 0)
            {
                TDDebug("NAL STBCMD &&&&&&&&& 1x\n");
                char *pCmdStr;
                pCmdStr = malloc(strlen(buffer) + 1);
                memset(pCmdStr,0,strlen(buffer)+1);
                strcpy(pCmdStr,buffer);
            }
            else
            {
            }
        }
    }

    return 0;
}
