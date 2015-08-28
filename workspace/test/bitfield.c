#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

typedef unsigned char uint8;
typedef unsigned short uint16;

typedef struct
{ 
  uint8  control : 2;
  uint16 r_val : 14;
  uint8  abp : 2;
  uint8  testmode : 2;
  uint8  ldprec : 1;
  uint8  sync : 1;
  uint8  dly : 1;
  uint8  resrv : 1;
} S1;

typedef struct
{ 
  uint8   control : 2;
  uint8   a_val : 6;
  uint16  b_val : 13;
  uint8   cpgain : 1;
  uint8   resrv : 2;
} S2;

typedef struct {
	char a1;
	short b1;
	int c1;
} SS;

typedef struct
{ 
	uint8  control : 2;
	uint8  counter_rst : 3;
	uint8  pdown1 : 3;
	uint8  mux_control : 5;
	char cc;
	uint16  b_val : 11;
	uint8   cpgain : 3;

//	uint8  r1 : 5;
} S3;

typedef union {
	char a1;
	int a2;
	short a3;

	SS s1;
} U1;

void dump(char *buf, int len)
{
	int i;
	for(i = 0; i < len; i ++) {
		printf("%02X", (unsigned char)buf[i]);
	}
	printf("\n");
}

void main() {
	S3 s3 = {0};
	int *p = (int*)&s3;
	int v1 = 0;
	
	printf("sizeof: %d\n", sizeof(S3));
	dump(&s3, sizeof(s3));

	s3.control = 0xFFFF; dump(&s3, sizeof(s3));
	s3.counter_rst = 0xFFFF; dump(&s3, sizeof(s3));
	s3.pdown1 = 0xFFFF; dump(&s3, sizeof(s3));
	s3.mux_control = 0xFFFF; dump(&s3, sizeof(s3));
	s3.cc = 0xFFFF; dump(&s3, sizeof(s3));
	s3.b_val = 0xFFFF; dump(&s3, sizeof(s3));
	s3.cpgain = 0xFFFF; dump(&s3, sizeof(s3));

//	U1 u1 = {0};
//	u1.a2 = 0x1A2B3C4D;
//	printf("%08X\n", u1.a1);
//	printf("%08X\n", u1.a2);
//	printf("%08X\n", u1.a3);
//	printf("%08X\n", u1.s1.a1);
//	printf("%08X\n", u1.s1.b1);
//	printf("%08X\n", u1.s1.c1);
}
