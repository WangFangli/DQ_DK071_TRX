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
;//***********************************************************
;//IO define set
;//************************************************************
	H  	equ 1
	L  	equ 0
	I  	equ 1  	;//input
	O  	equ 0  	;//output
	En  equ	0  	;//Enable
	Dis  equ	1  	;//Disenable
    WEn equ     1
    WDis equ    0
;//********************************************
;//IO Driver set
;//*********************************************
 RFCSNDR_Pb7    equ	   	H   ;//CSN
 PRFSCKDR_Pa2   equ	   	L  	;//SCK
 PRFMOSIDR_Pa1  equ	    L   ;//MOSI  	 
 PRFCEDR_Pa0    equ	   	L  	;//CE
;//*********************************************
 if C_MODE_RX_En
 P13DR_Pa3      equ	    L
 P11DR_Pb0      equ	    L
 P10DR_Pb1      equ	    L
 P9DR_Pb2       equ	   	L
 P8DR_Pb3       equ	   	L
 P7DR_Pb4       equ	   	L
 P6DR_Pb5       equ	   	L
 P4DR_Pb6       equ	   	L
 else
 P13DR_Pa3      equ	    L
 P11DR_Pb0      equ	    L
 P10DR_Pb1      equ	    L
 P9DR_Pb2       equ	   	L
 P8DR_Pb3       equ	   	L
 P7DR_Pb4       equ	   	L
 P6DR_Pb5       equ	   	L
 P4DR_Pb6       equ	   	L
 endif

 #define PADR_SET       PRFCEDR_Pa0|(PRFMOSIDR_Pa1<<1)|(PRFSCKDR_Pa2<<2)|(P13DR_Pa3<<3)
 #define PBDR_SET       P11DR_Pb0|(P10DR_Pb1<<1)|(P9DR_Pb2<<2)|(P8DR_Pb3<<3)|(P7DR_Pb4<<4)|(P6DR_Pb5<<5)|(P4DR_Pb6<<6)|(RFCSNDR_Pb7<<7)
;//********************************************
;// IO input/ output set
;//*********************************************
 RFCSNIO_Pb7    equ	   	O   ;//CSN
 PRFSCKIO_Pa2   equ	   	O  	;//SCK
 PRFMOSIIO_Pa1  equ	    O   ;//MOSI  	 
 PRFCEIO_Pa0    equ	   	O  	;//CE
;//*********************************************
 if C_MODE_RX_En
 P13IO_Pa3      equ	    O
 P11IO_Pb0      equ	    O
 P10IO_Pb1      equ	    O
 P9IO_Pb2       equ	   	O
 P8IO_Pb3       equ	   	O
 P7IO_Pb4       equ	   	O
 P6IO_Pb5       equ	   	O
 P4IO_Pb6       equ	   	O
 else
 P13IO_Pa3      equ	    O
 P11IO_Pb0      equ	    O
 P10IO_Pb1      equ	    I
 P9IO_Pb2       equ	   	I
 P8IO_Pb3       equ	   	I
 P7IO_Pb4       equ	   	I
 P6IO_Pb5       equ	   	I
 P4IO_Pb6       equ	   	I
 endif

 #define PAIO_SET       PRFCEIO_Pa0|(PRFMOSIIO_Pa1<<1)|(PRFSCKIO_Pa2<<2)|(P13IO_Pa3<<3)
 #define PBIO_SET       P11IO_Pb0|(P10IO_Pb1<<1)|(P9IO_Pb2<<2)|(P8IO_Pb3<<3)|(P7IO_Pb4<<4)|(P6IO_Pb5<<5)|(P4IO_Pb6<<6)|(RFCSNIO_Pb7<<7)

;//********************************************
;//IO pull En/Dis set
;//*********************************************
 RFCSNPU_Pb7    equ	   	Dis     ;//CSN
 PRFSCKPU_Pa2   equ	   	Dis  	;//SCK
 PRFMOSIPU_Pa1  equ	    Dis     ;//MOSI  	 
 PRFCEPU_Pa0    equ	   	Dis  	;//CE
;//*********************************************
 if C_MODE_RX_En
 P13PU_Pa3      equ	    En
 P11PU_Pb0      equ	    En
 P10PU_Pb1      equ	    Dis
 P9PU_Pb2       equ	   	Dis
 P8PU_Pb3       equ	   	En
 P7PU_Pb4       equ	   	Dis
 P6PU_Pb5       equ	   	Dis
 P4PU_Pb6       equ	   	Dis
 else
 P13PU_Pa3      equ	    Dis
 P11PU_Pb0      equ	    Dis
 P10PU_Pb1      equ	    En
 P9PU_Pb2       equ	   	En
 P8PU_Pb3       equ	   	En
 P7PU_Pb4       equ	   	En
 P6PU_Pb5       equ	   	En
 P4PU_Pb6       equ	   	En
 endif

 #define PAPU_SET       PRFCEPU_Pa0|(PRFMOSIPU_Pa1<<1)|(PRFSCKPU_Pa2<<2)|(P13PU_Pa3<<3)
 #define PBPU_SET       P11PU_Pb0|(P10PU_Pb1<<1)|(P9PU_Pb2<<2)|(P8PU_Pb3<<3)|(P7PU_Pb4<<4)|(P6PU_Pb5<<5)|(P4PU_Pb6<<6)|(RFCSNPU_Pb7<<7)


;//********************************************
;//IO wake En/Dis set
;//*********************************************
 RFCSNWU_Pb7    equ	   	WDis     ;//CSN
;//*********************************************
 if C_MODE_RX_En
 P11WU_Pb0      equ	    WDis
 P10WU_Pb1      equ	    WDis
 P9WU_Pb2       equ	   	WDis
 P8WU_Pb3       equ	   	WDis
 P7WU_Pb4       equ	   	WDis
 P6WU_Pb5       equ	   	WDis
 P4WU_Pb6       equ	   	WDis
 else 
 P11WU_Pb0      equ	    WDis
 P10WU_Pb1      equ	    WEn
 P9WU_Pb2       equ	   	WEn
 P8WU_Pb3       equ	   	WEn
 P7WU_Pb4       equ	   	WEn
 P6WU_Pb5       equ	   	WEn
 P4WU_Pb6       equ	   	WEn
 endif

 #define PBWU_SET       P11WU_Pb0|(P10WU_Pb1<<1)|(P9WU_Pb2<<2)|(P8WU_Pb3<<3)|(P7WU_Pb4<<4)|(P6WU_Pb5<<5)|(P4WU_Pb6<<6)|(RFCSNWU_Pb7<<7)


 PCON_SET  equ     0x88
;//****************************************************