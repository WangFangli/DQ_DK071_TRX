;// =========================================================================      
;// Project:       DK068
;// File:          StartRun.asm 
;// Description:   program start run in here
;// RF Mode : duplex / simplex                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/14
;// =========================================================================
;//--------------- File Include ---------------------------------------------
;//--------------------------------------------------------------------------
#include		NY8A053D.H					;//The Header File for AT8B62D 
#include   		USER_SET.asm
#include   		RAM_MAP.asm
#include   		IO_DEFINE_SET.asm
;#include		Func_Macro.asm

      
;//--------------- Vector Defination ----------------------------------------
;//--------------------------------------------------------------------------
		ORG			0x000		
		nop
		nop
   		lgoto		MAIN
        ORG			0x003	
ROLL0:
   		retia		0
        ORG			0x004
ROLL1:
   		retia		0
        ORG			0x005
ROLL2:
   		retia		0
        ORG			0x006
ROLL3:
   		retia		0

   		ORG     	0x008
   		lgoto   	INTERRUPT
;/**********************************************************
;Table
;**********************************************************/
TABLE_RF_REG:
	movr	WriteData_VTM,0
	addar	PCL,1

	retia   0x5e
	retia   0x80

    retia   0x46
    retia   0x03

	retia	1
	lgoto   CARRIER_0

	retia	4
	retia	0xc2

;	retia	8
;	retia	0x25

	retia	17
	retia	0x3a

	retia	18
	lgoto	RF_POWR

    retia   22
    lgoto   CARRIER_3

	retia	34
	retia	0x08

	retia	35
	retia	0x08

    retia   45
    retia   0x07

	retia	46
	retia	0x09

	retia	52	;//control VCO?
	retia	0x19

	retia	53
	retia	0x40

	retia	64	
	retia	0x78	;//1byte	preamble	4bit Trailer	64bit	syncword

	retia	65
	lgoto   CARRIER_1

    retia   81
    retia   0x42

	retia	82
	retia	0xf0

	retia	71
	lgoto	RF_SCR

    retia   68
    lgoto   CARRIER_2   

	retia	0xff

RF_POWR:
	btrss	_flag_build
	retia	0x0c	
	retia	0x38
CARRIER_0:
    btrss   _flag_Carrier
    retia   0xe9
    retia   0xf8
CARRIER_1:
    btrss   _flag_Carrier
    retia   0x00
    retia   0x01
CARRIER_2:
    btrss   _flag_Carrier
    retia   0x00
    retia   0xb0
CARRIER_3:
    btrss   _flag_Carrier
    retia   0x03
    retia   0x83
RF_SCR:
if C_MODE_RX_En
	btrss	_flag_ScanMode
	retia	Scramble_CTM|0x80
	retia	ScrambleP_CTM|0x80	
else
	btrss	_flag_Build 
	retia	Scramble_CTM|0x80
	retia	ScrambleP_CTM|0x80
endif	

;#include		RF_config.asm
if C_MODE_RX_En
#include		main.asm
#include		SLEEP_MODE.asm
#include		MOTOR.asm
#include 		Lamp_Control.asm
#include		RF_config.asm
#include        F_DELAY.asm
#include        INITIAL_REG.asm
#include        INTERRUPT.asm
else
#include		main.asm
#include		SLEEP_MODE.asm
#include		ScanButton.asm
#include 		Lamp_Control.asm
#include		RF_config.asm
#include        F_DELAY.asm
#include        INITIAL_REG.asm
#include        INTERRUPT.asm
if C_TestMode_En
#include		TEST_MODE_ENTER.asm
endif
endif

end											;//End of Code