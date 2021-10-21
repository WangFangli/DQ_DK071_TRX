;//****************************************

ifndef __RF_CONFIG
#define __RF_CONFIG

;//#include	F_RFSPI.h
;// =========================================================================      
;// Project:       
;// File:          RF_config.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/14
;// ========================================================================= 

;//0->70inst+25 +147 = 242 inst
INITIAL_RF:
    btrsc   _flag_RF_Reset
    ret
    lcall	DELAY_1ms
    bcr     PIN_CE
    lcall   DELAY_30ms
    bsr     PIN_CE
    lcall   DELAY_45ms
INITIAL_RF_DEF_REG:
    clrr   	WriteData_VTM
INITIAL_RF_DEF_REG_LOOP:
    lcall   TABLE_RF_REG
    incr    WriteData_VTM,1
    xoria   0xff
    btrsc   zf
    lgoto   INITIAL_RF_DEF_REG_END
    xoria   0xff
    lcall   SPI_RW
    lcall   TABLE_RF_REG
    incr    WriteData_VTM,1
    lcall   SPI_W_DATA
    bsr     PIN_CSN
    lgoto   INITIAL_RF_DEF_REG_LOOP
INITIAL_RF_DEF_REG_END:
    lcall	RF_CHANNEL_CHOICE
    lcall   RF_IDLE_MODE
    lcall   CLR_W_FIFO
    lcall   CLR_R_FIFO
;//    lcall   CHECK_2G4_REG
    bsr     _flag_RF_Reset
INITIAL_TEST_MODE:
    btrsc   _flag_Carrier
    lgoto   INITIAL_RF_CARRIER
if C_MODE_RX_En
    lgoto   EN_RX_MODE
endif
    ret
INITIAL_RF_CARRIER:    
    movia   0x4b
    lcall   RF_RX_MODE1
    movia   18 | 0x01
    lgoto   RF_TX_MODE1
;//**************************************************
EN_RX_MODE:
    bsr     PIN_CSN
    lcall   RF_IDLE_MODE
    lcall   CLR_W_FIFO
    lcall   CLR_R_FIFO
    lcall   RF_RX_MODE
    lcall	DELAY_500us
    ret     
;//**************************************************
CLR_W_FIFO:
    movia   0x68
    lgoto   CLR_REG
CLR_R_FIFO:
    movia   0x69
CLR_REG:
    lcall   SPI_RW
    movia   0x80
    lcall   SPI_W_DATA
    bsr     PIN_CSN
    ret
;//**************************************************
;// sleep? LNA off Mode 3 - 0:Auto ACK
RF_MIS_REG:
   movia    0x43
   movar    WriteData_VTM
   movia    0x46
   lgoto    SPI_SOLO_REG

RF_SCR_REG:
   lcall    RF_SCR    
   movar    WriteData_VTM
   movia    71
   lgoto    SPI_SOLO_REG
;//**************************************************
;//**************************************************
RF_TX_MODE:
    movia   0x01
RF_TX_MODE1:
    movar   WriteData_VTM
    lgoto   RF_WORK_MODE1
;//**************************************************
RF_RX_MODE:
    movr    RFValue_VTM,0
    ioria   0x80
RF_RX_MODE1:
    movar   WriteData_VTM
    movia   0x0f
    lgoto   SPI_SOLO_REG
;//**************************************************
RF_IDLE_MODE:
    movr    RFValue_VTM,0
;//**************************************************
RF_WORK_MODE:
    movar   WriteData_VTM
    movia   0x0f
    lcall   SPI_SOLO_REG
    clrr    WriteData_VTM
RF_WORK_MODE1:
    movia   0x0e
SPI_SOLO_REG:
    lcall   SPI_RW
    movr    WriteData_VTM,0
SPI_SOLO_REG1:
    lcall   SPI_W_DATA
    bsr     PIN_CSN
    ret
;//**************************************************
;//CHECK_2G4_REG:
;//    movia   71
;//    lcall   SPI_R
;//    lcall   SPI_R_DATA
;//    bsr     PIN_CSN
;//    movr    TempData_VTM,0
;//    xoria   0xf6
;//    btrsc   zf
;//    lgoto   CHECK_2G4_REG_OK
;//    movia   0x0f
;//    lcall   SPI_R
;//    lcall   SPI_R_DATA
;//    bsr     PIN_CSN
;//    movr    TempData_VTM,0
;//    andia   0x7f
;//    xorar   RFValue_VTM,0
;//    btrsc   zf
;//    lgoto   CHECK_2G4_REG_OK
;//    bsr     _flag_2G4Error
;//    lgoto   CHECK_2G4_REG_END
;//CHECK_2G4_REG_OK:
;//    bcr     _flag_2G4Error
;//CHECK_2G4_REG_END:
;//    ret
;//**************************************************
;//SPI need CSN H > 250ns
;//SPI byte byte > 450ns
;//SPI over -> CSN > 200ns
;//SPI CSN L->Data > 20ns
;//SPI cycle > 83ns
;//->25inst
;//**************************************************
SPI_R:
    ioria   0x80
SPI_RW:
    bcr     PIN_CSN
SPI_W_DATA:
    movar   TempData_VTM
    iostr   porta
    andia   0xfb
SPI_RW_READY:    
    iost    porta
    movia   8
    movar   Temp_VTM
SPI_RW_LOOP:
    bcr     cf
    rlr     TempData_VTM,1
    btrss   cf
    bcr     PIN_MOSI
    btrsc   cf
    bsr     PIN_MOSI    
    bsr     PIN_CLK
    btrsc   PIN_MOSI
    bsr     TempData_VTM,0
    bcr     PIN_CLK
    decrsz  Temp_VTM,1
    lgoto   SPI_RW_LOOP
    movr    TempData_VTM,0
    ret
SPI_R_DATA:
    iostr   porta
    ioria   0x04
    lgoto   SPI_RW_READY
;//**********************************************************
;//ROLL Code -> Channel?
;//147 inst?
;//-> roll0 -> sendData0_VTM
;//-> roll1 -> sendData1_VTM
;//-> roll2 -> sendData2_VTM
;//-> roll3 -> sendData3_VTM
;//-> ch0 -> sendData7_VTM
;//-> ch1 -> sendData8_VTM
;//-> ch2 -> sendData9_VTM
;//-> Addr_CH -> sendData6_VTM
;//**********************************************************/	
#define		StartLCH_CTM		10	;//基本通道
#define		LengthCH_CTM		75	;//通道范围  

ROLL_CHANNEL:
    movia   0x5d 
    xorar   sendData0_VTM,0
    addar   sendData1_VTM,0
    xoria   0xd2 
    addar   sendData2_VTM,0
    subar   sendData3_VTM,0
    movar   TempData_VTM
    lcall   ROLL_STEP_0_78 ;//10 - 85

ROLL_STEP0:
	movr	TempData_VTM,0
	movar	sendData7_VTM		;//first channel
ROLL_CHANNEL1:
    movia   0x33 
    xorar   sendData1_VTM,0
    addar   sendData2_VTM,0
    xoria   0x49 
    addar   sendData3_VTM,0
    movar   TempData_VTM
ROLL_STEP1:
    movr    sendData7_VTM,0
    addar   TempData_VTM,1
    lcall   ROLL_STEP_0_78  ;//10 - 85
    movr    TempData_VTM,0
    subar   sendData7_VTM,0
    btrss   cf
    xoria   0xff
    subia   6
    btrss   cf
    lgoto   ROLL_STEP11
    movia   12
    addar   TempData_VTM,0
    lcall   ROLL_STEP_0_78
ROLL_STEP11:
    movr    TempData_VTM,0
    movar   sendData8_VTM
ROLL_CHANNEL2:	;//在 差距大的一段中截取一个数据
	movr	sendData8_VTM,0
	subar	sendData7_VTM,0
	btrss	cf
	xoria	0xff
	movar	TempData_VTM
	subia	(LengthCH_CTM-StartLCH_CTM)>>1 ;//0x20
	btrss	cf
	lgoto	ROLL_CHANNEL21
ROLL_CHANNEL22: ;//0-0x20
	movr	TempData_VTM,0
	subia	LengthCH_CTM-StartLCH_CTM ;//65 - (0-0x20)
	movar	TempData_VTM    ;//65 - 33?
	lcall	ROLL_CHANNEL2_  ;//53 - 21
    movr    sendData7_VTM,0
    subar   sendData8_VTM,0
    movr    sendData7_VTM,0
    btrsc   cf
    movr    sendData8_VTM,0
    addia   6
    addar   WriteData_VTM,0
    movar   TempData_VTM
    lcall   ROLL_STEP_0_78
    movr    TempData_VTM,0
    movar   sendData9_VTM
    lgoto   ROLL_CHANNEL_LIMITED  

ROLL_CHANNEL21:
	lcall	ROLL_CHANNEL2_  ;//53 - 21

	movr	sendData7_VTM,0
	subar	sendData8_VTM,0
	movr	sendData7_VTM,0
	btrss	cf
	movr	sendData8_VTM,0
	addia	6
	addar	WriteData_VTM,0
	movar	sendData9_VTM
   
ROLL_CHANNEL_LIMITED:
    movr    sendData6_VTM,0
    movar   FSR 
    lcall   CH_LIMITED 
    incr    FSR,1
    lcall   CH_LIMITED 
    incr    FSR,1
    lcall   CH_LIMITED 

    movr    sendData6_VTM,0
    movar   FSR     ;//->TXCH0_VTM
    movr    sendData8_VTM,0
    lcall   ROLL_CH_EQUAL

    incr    FSR,1
    incr    FSR,1   ;//->TXCH2_VTM
    movr    sendData7_VTM,0
    lcall   ROLL_CH_EQUAL

    movr    sendData8_VTM,0
    lcall   ROLL_CH_EQUAL   

ROLL_CHANNEL_END:
	ret
;//87
;//*********************************************************
ROLL_STEP_0_75:
	movr    TempData_VTM,0
	subia	73
	btrsc	cf
	lgoto	ROLL_STEP_0_75_END
	movia	73
	subar	TempData_VTM,1
	lgoto	ROLL_STEP_0_75
ROLL_STEP_0_75_END:
	movr	TempData_VTM,0
    subia	10
    btrss	cf
    lgoto	ROLL_10_75_STEP_END
	movia	StartLCH_CTM		;//3	;基本通道
	addar	TempData_VTM,1
ROLL_10_75_STEP_END:
	ret
;//*********************************************************
ROLL_STEP_0_78:
	clrwdt
	movr	TempData_VTM,0
	subia	LengthCH_CTM
	btrsc	cf
	lgoto	ROLL_STEP_0_78_END
	movia	LengthCH_CTM
	subar	TempData_VTM,1
	lgoto	ROLL_STEP_0_78
ROLL_STEP_0_78_END:
	movia	StartLCH_CTM		;//3	;基本通道
	addar	TempData_VTM,1  ;//10-85
	ret	
;//*********************************************************
ROLL_CHANNEL2_:
    movia   12
    subar   TempData_VTM,0
    movia   0xae 
    xorar   sendData2_VTM,0
    addar   sendData3_VTM,0
    xoria   0x63
    addar   sendData0_VTM,0
    movar   WriteData_VTM
ROLL_CHANNEL2_LOOP:
	clrwdt
	movr	TempData_VTM,0
	subar	WriteData_VTM,0 ;//->53 - 21 
	btrss	cf
	lgoto	ROLL_CHANNEL2_END
	movar	WriteData_VTM
	lgoto	ROLL_CHANNEL2_LOOP
ROLL_CHANNEL2_END:
	ret		
;//******************************************
CH_LIMITED:
    movia   73
    subar   INDF,0
    btrsc   cf 
    movar   INDF
    ret
;//******************************************
ROLL_CH_EQUAL:
    xorar   INDF,0
    btrss   zf 
    ret
    movia   0x0c
    addar   INDF,0
    movar   TempData_VTM
    lcall   ROLL_STEP_0_75
    movr    TempData_VTM,0
    movar   INDF 
    ret
;/**********************************************************
;RF_CHANNEL_CHOICE
;正常通道要避开对码通道，通道算法要尽量差异大，通道间的间隔
;最好保持6个通道或者以.
;**********************************************************/	
RF_CHANNEL_CHOICE:
	btrss	_flag_test
RF_CHANNEL_CHOICE0:
	incr	ChannelCount_VTM,1	
	btrss	ChannelCount_VTM,1
	lgoto	RF_CHANNEL_CHOICE01
	btrss	ChannelCount_VTM,0
	lgoto	RF_CHANNEL_CHOICE2
	lgoto	RF_CHANNEL_CHOICE3
RF_CHANNEL_CHOICE01:
	btrsc	ChannelCount_VTM,0
	lgoto	RF_CHANNEL_CHOICE1
RF_CHANNEL_CHOICE4:
	btrss	_flag_test
	lgoto	RF_CHANNEL_CHOICE0
	bcr		_flag_test
	bcr		_flag_RF_reset
	bcr		_flag_Carrier
	lgoto	RF_CHANNEL_CHOICE_END
RF_CHANNEL_CHOICE3:
    movr    TXCH2_VTM,0
    btrsc   ChannelCount_VTM,2
    movr    RXCH2_VTM,0
if C_MODE_RX_En
    btrsc   _flag_ScanMode
else
    btrsc   _flag_Build 
endif
    movia   PRCH2_CTM

	btrsc	_flag_test
	movia	TESTCH2_CTM
	lgoto	RF_CHANNEL_CHOICE_OUT
RF_CHANNEL_CHOICE2:
	movr    TXCH1_VTM,0
    btrsc   ChannelCount_VTM,2
    movr    RXCH1_VTM,0
if C_MODE_RX_En
    btrsc   _flag_ScanMode
else
    btrsc   _flag_Build 
endif
    movia   PRCH1_CTM

	btrsc	_flag_test
	movia	TESTCH1_CTM
	lgoto	RF_CHANNEL_CHOICE_OUT
RF_CHANNEL_CHOICE1:
	movr    TXCH0_VTM,0
    btrsc   ChannelCount_VTM,2
    movr    RXCH0_VTM,0
if C_MODE_RX_En
    btrsc   _flag_ScanMode
else
    btrsc   _flag_Build 
endif
    movia   PRCH0_CTM

	btrsc	_flag_test
	movia	TESTCH0_CTM
RF_CHANNEL_CHOICE_OUT:
	movar	RFValue_VTM	
RF_CHANNEL_CHOICE_END:
	ret
endif  