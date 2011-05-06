#include <stdio.h>

#define WORD unsigned short
#define DWORD unsigned int

#pragma pack(1)
typedef struct tagBITMAPFILEHEADER {
  WORD bfType;
  DWORD bfSize; /* file size */
  WORD bfReserved1;
  WORD bfReserved2;
  DWORD bfOffBits; /* data offset */
} BITMAPFILEHEADER,*LPBITMAPFILEHEADER;
#pragma pack()

int main()
{
    printf("%d\n", sizeof(BITMAPFILEHEADER));
    return 0;
}
