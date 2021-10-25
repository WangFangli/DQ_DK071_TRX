;//*******************************************
;//	2401	  ____________	
;//		ANTN-|1			16|-XTOUT
;//		ANTP-|2			15|-XTIN
;//		VSS	-|3			14|-VDD1
;//		PB6	-|4			13|-PA3
;//		VDD	-|5			12|-VSS
;//		PB5 -|6			11|-PB0
;//		PB4 -|7			10|-PB1
;//		PB3	-|8__________9|-PB2
;//
;//*******************************************

;//#define     C_DK068     1
#define     C_MODE_RX_En    1   ;//TX 0/ RX 1
#define     C_DK071         0   ;//MODE in TX  DK071TX = 1 DK068TX = 0
#define     C_TestMode_En   1   ;//enable test mode
;#define 	C_RX_En			0

;//****************************************
;//RF define
#define     FIFO_EN_CTM     0x64
#define     RFStatus_CTM    0x61
#define     C_CRC_adr       0x60

#define TXData_Length_CTM   7
#define RXData_Length_CTM   11
#define C_ACK_Length    10

#define	PRCH0_CTM		12	;//2414
#define	PRCH1_CTM		38	;//2440	
#define	PRCH2_CTM		69	;//2471

#define	TESTCH0_CTM		8	;//2410
#define	TESTCH1_CTM		41	;//2443	
#define	TESTCH2_CTM		73	;//2475

#define Scramble_CTM    0x1a
#define ScrambleP_CTM   0x25


#define     C_longPair      17
#define     C_shortPair     2
#define     C_5min          167
#define 	C_5min_RX		112
#define     C_2s            1
;//****************************************
#define    PIN_CLK     porta,1
#define    PIN_MOSI    porta,2
#define    PIN_CSN     portb,7
#define    PIN_CE      porta,0

if C_MODE_RX_En
#define PIN_MF      Portb,5
#define PIN_MB      Portb,6
#define PIN_ML      Portb,4
#define PIN_MR      Portb,1
#define PIN_LAMP    Portb,2
else
#define PIN_TU      Portb,6
#define PIN_R       Portb,5
#define PIN_L       Portb,4
#define PIN_F1      Portb,3
#define PIN_B       Portb,2
#define PIN_F       Portb,1
#define PIN_Lamp    Portb,0
#define PIN_TULamp  Porta,3
endif 

_L 	   	   	equ   	6
_R 	   	   	equ   	5
_F 	   	   	equ   	1
_B 	   	   	equ   	0
_T          equ     2

#define     C_LRFB      0x63
#define     C_LF        0x42
#define     C_LB        0x41
#define     C_FB        0x03
#define     C_R         0x20
;/*********************************************************