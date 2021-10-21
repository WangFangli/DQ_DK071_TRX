;//=========================================================================      
;//Project:       TX_COMMON
;//File:          Main.asm
;//Description:   ROM checksum calculation
;//                1. CheckSum Range : Compilier will Produce 2-Word CheckSum Value Automatically and Place in Tail of Program
;//                2. If Checksum is correct, PortB = 0x55
;//                3. If Chechsum is incorrect, PortB = 0xF0
;//Author:        WangFangli
;//Version:       V1.0
;//Date:          2021/7/14
;//=========================================================================
         
MAIN:
;//Power ON initial - User program area
   	lcall    	INITIAL_ROUTINE
   	lcall    	DELAY_45ms 
   	lcall    	INITIAL_ROUTINE
   	lcall    	CLEAR_SRAM
	lcall		UPDATA_TXCH
	lcall		UPDATA_RXCH
	
   	lcall		INITIAL_RF
   	bcr			_flag_RF_Reset
if C_MODE_RX_En
	bsr 		INTE,0
	eni
else
if C_TestMode_En
	lcall 		TESTMODE_ENTER
	btrsc		_flag_test
	lgoto		MAIN_LOOP
endif 

endif
if C_MODE_RX_En == 0
if C_DK071 == 0
	btrsc		PIN_TU
	bsr			_flag_sleep
endif 
endif

	bsr			_flag_Build
	bsr			_flag_BuildLED	

MAIN_LOOP:
	clrwdt
;//	movia		0x01
;//	xorar		Portb,1
if C_MODE_RX_En ==0
	movr 		V_system1T,0
	subia		1	;//256*2*2 = 1s?
	btrss		cf
	bsr			_flag_Start

	btrsc		_flag_BuildLED
	lgoto		MAIN_LOOP_STEP0
	btrss		_flag_Start	;//start step once
	lgoto		MAIN_LOOP_STEP0	
MAIN_LOOP_STEP_OVER:
	btrss		_flag_build
	lgoto		MAIN_LOOP_STEP0
	bcr			_flag_RF_Reset
	bcr			_flag_Build
	clrr		V_systemT
	clrr		V_system1T
endif
;// main loop is 10ms
MAIN_LOOP_STEP0:
;//TX mode 7ms?
;//RX mode 1ms?
if C_MODE_RX_En
	incr		V_system0T,1
	movia		7
	subar		V_system0T,0
	btrss		cf
	lgoto		MAIN_LOOP_STEP0_START
	clrr		V_system0T
	lcall		MOTOR_CONTROL	;//7ms?
endif
	incr		V_systemT,1	;//7ms? * 256 => 1024
	btrsc		zf
	incr		V_system1T,1
if C_MODE_RX_En
MAIN_LOOP_STEP0_START:
	lcall		DELAY_1ms 
	lcall		SCAN_MODE
	movia		C_5min_RX
	subar		V_system1T,0
	btrsc		cf
	bsr			_flag_sleep
else
	btrsc		_flag_Build
	lgoto		MAIN_LOOP_STEP1_PAIROUT
	btrss		_flag_BuildLED
	lgoto		MAIN_LOOP_STEP1
MAIN_LOOP_STEP1_PAIROUT:
	movia		C_longPair
	btrsc		_flag_BuildL
	movia		C_shortPair
	subar		V_system1T,0
	btrss		cf
	lgoto		MAIN_LOOP_STEP1
	btrss		_flag_Build
	lgoto		MAIN_LOOP_STEP1_PAIROUT1
	bcr			_flag_RF_Reset
	bcr			_flag_Build	
MAIN_LOOP_STEP1_PAIROUT1:
	bcr			_flag_BuildLED
MAIN_LOOP_STEP1:
if C_MODE_RX_En
	movia		C_5min
else
if C_DK071 == 0 
	btrss		V_key,_T
	bsr			_flag_sleep
endif 
	btrsc		_flag_Build
	lgoto		MAIN_LOOP_STEP4
	btrsc		_flag_BuildLED
	lgoto		MAIN_LOOP_STEP4
	movr 		V_key,0
;//	andia		C_LRFB
	btrss		zf
	lgoto		MAIN_LOOP_STEP2
	movia		C_2s
	lgoto		MAIN_LOOP_STEP3
MAIN_LOOP_STEP2:
	movia		C_5min 
endif
MAIN_LOOP_STEP3:
	subar		V_system1T,0
	btrss		cf
	lgoto		MAIN_LOOP_STEP4
	bsr			_flag_sleep
MAIN_LOOP_STEP4:
if C_TestMode_En
	btrsc		_flag_test
	lgoto		MAIN_LOOP_STEP5
endif 
endif
	lcall		SCAN_SLEEP
MAIN_LOOP_STEP5:
if C_MODE_RX_En == 0 
	lcall		SCAN_BUTTON
endif
	lcall		LAMP_CONTROL
	lcall		INITIAL_RF

if C_MODE_RX_En
	lgoto		MAIN_RX
endif
MAIN_TX_MODE:
if C_TestMode_En
	btrsc		_flag_Carrier
	lgoto		TX_WAIT_DELAY
	btrss		_flag_test
	lgoto		MAIN_TX_NOR
	incr		Test_VTM,1
	movia		3
	subar		Test_VTM,0
	btrss		cf
	lgoto		TX_WAIT_DELAY
	clrr		Test_VTM
endif 
MAIN_TX_NOR:
;//	btrsc		_flag_Build
;//	lgoto		MAIN_TX_NOR_SEND
;//MAIN_TX_NOR_SEND:
	lcall		RF_CHANNEL_CHOICE
if C_MODE_RX_En == 0
	movr 		V_Key,0
	btrsc		_flag_Build
	movia		0
	movar		sendData0_VTM
	btrsc		sendData0_VTM,_F
	lgoto		MAIN_TX_NOR_NEXT0
	movia		0xf9
	andar		sendData0_VTM,1
MAIN_TX_NOR_NEXT0:
	btrsc		_flag_build
	lgoto		MAIN_TX_NOR_NEXT01
	movia		0x04
	xorar		V_Key,0
	btrss		zf
	lgoto		MAIN_TX_NOR_NEXT01
	incr		Test_VTM,1
	movia		0x20
	subar		Test_VTM,0
	btrss		cf
	lgoto		MAIN_TX_NOR_NEXT02
	movia		0x30
	movar		Test_VTM
	lcall		DELAY_1ms
	lcall		DELAY_1ms
	lcall		DELAY_1ms
	lgoto		TX_WAIT_DELAY
MAIN_TX_NOR_NEXT01:		
	clrr		Test_VTM	
MAIN_TX_NOR_NEXT02:
	movia		0x3c
	btrsc		_flag_Build
	movia		0x88
	movar		sendData1_VTM
	
	lcall		ROLL0
	movar		sendData2_VTM
	lcall		ROLL1
	movar		sendData3_VTM
	lcall		ROLL2
	movar		sendData4_VTM
	lcall		ROLL3
	movar 		sendData5_VTM

	movr 		V_RXROLL0,0
	movar		sendData6_VTM
	movr 		V_RXROLL1,0
	movar		sendData7_VTM
	movr 		V_RXROLL2,0
	movar		sendData8_VTM
	movr 		V_RXROLL3,0
	movar 		sendData9_VTM
endif
MAIN_TX_NOR_SEND:
	lcall		RF_IDLE_MODE
	lcall		CLR_W_FIFO

	movia		FIFO_EN_CTM
	lcall		SPI_RW
if C_MODE_RX_En
	movia    	C_ACK_Length
else
	movia		TXData_Length_CTM
    btrsc   	ChannelCount_VTM,2
    movia    	RXData_Length_CTM
	btrsc		_flag_Build
	movia		TXData_Length_CTM
endif
	movar		ReadData_VTM
	movar		Delay_VTM 
	lcall		SPI_W_DATA
	decr		Delay_VTM,1
	movia		HeadRAM_ADR
	movar 		FSR 
TX_SEND_LOOP:
	movr 		INDF,0
	addar 		ReadData_VTM,1
	lcall		SPI_W_DATA
	incr		FSR,1
	decrsz		Delay_VTM,1 
	lgoto		TX_SEND_LOOP
	movr 		ReadData_VTM,0
	lcall		SPI_W_DATA		
	bsr			PIN_CSN
	lcall		RF_TX_MODE
	lcall		DELAY_1ms 

	lcall		SCAN_PEAK
	btrsc		zf 
	lgoto		MAIN_TX_NOR_SEND_OK
	bcr 		_flag_RF_Reset
	lgoto		MAIN_LOOP
MAIN_TX_NOR_SEND_OK:
if C_MODE_RX_En
	lcall		EN_RX_MODE
	lgoto		MAIN_LOOP
else
if C_TestMode_En
	btrsc		_flag_test
	lgoto		TX_WAIT_DELAY
endif		
	btrss		_flag_Build
	lgoto		TX_WAIT_DELAY
	lcall		EN_RX_MODE
	lcall		DELAY_4ms
endif

;//------- RX Mode ------------------------------------------
MAIN_RX:
   	lcall   	SCAN_PEAK
   	btrss  	   	zf
   	lgoto   	MAIN_LOOP
RX_WAIT_OK:
   	movia  	   	C_CRC_adr 
   	lcall   	SPI_R
   	lcall   	SPI_R_DATA
   	bsr   	   	PIN_CSN
   	btrsc  	   	TempData_VTM,7
	lgoto		RX_WAIT_NEXT
	movia		FIFO_EN_CTM
	lcall		SPI_R 
	lcall		SPI_R_DATA 
	movar		WriteData_VTM
	movar		ReadData_VTM
	movar 		Delay_VTM
if C_MODE_RX_En
	xoria 		TXData_Length_CTM
	btrsc		zf 
	lgoto		RX_DATA_DECODE
	movr		ReadData_VTM,0
	xoria		RXData_Length_CTM
	btrss		zf
	lgoto		RX_WAIT_NEXT
else
	xoria 		C_ACK_Length
	btrss 		zf 
	goto		RX_WAIT_NEXT
endif
RX_DATA_DECODE:
	movia		DataRAM_ADR
	movar		FSR 
	decr 		Delay_VTM,1
RX_DATA_LOOP:
	lcall		SPI_R_DATA
	movar		INDF 
	addar		ReadData_VTM,1
	incr		FSR,1 
	decrsz		Delay_VTM,1
	lgoto		RX_DATA_LOOP
	lcall		SPI_R_DATA
	bsr			PIN_CSN
	xorar 		ReadData_VTM,0
	btrss		zf 
	goto		RX_WAIT_NEXT
if C_MODE_RX_En
	btrss		_flag_Build
	lgoto		RX_TXDATA_CK
	movia		0x88
	xorar 		sendData1_VTM,0
	btrsc		zf
	lgoto		RX_PAIR_TXROLL_NEXT
	movia		0x3c
	xorar		sendData1_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	movia		RXData_Length_CTM
	xorar		WriteData_VTM,0
	btrss		zf
	lgoto		RX_TXDATA_CK	

	lcall		ROLL0
	xorar		sendData6_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	lcall		ROLL1
	xorar		sendData7_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	lcall		ROLL2
	xorar		sendData8_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	lcall		ROLL3
	xorar		sendData9_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT

;//	bcr			_flag_Build
;//	bcr			_flag_RF_Reset
	movr 		sendData2_VTM,0
	movar		V_RXROLL0
	movr 		sendData3_VTM,0
	movar		V_RXROLL1
	movr 		sendData4_VTM,0
	movar		V_RXROLL2
	movr 		sendData5_VTM,0
	movar		V_RXROLL3
	lcall		UPDATA_RXCH
	lgoto		RX_PAIR_FIRST_JUAGE
;	bcr			_flag_Build
;	bcr			_flag_RF_Reset
;	bsr			_flag_LRturnTrig
;	clrr		Test_VTM
;	lgoto		RX_WAIT_NEXT
RX_PAIR_TXROLL_NEXT:
	movr		sendData2_VTM,0
	xorar		V_RXROLL0,0
	btrss		zf
	clrr		V_PairTimeCT
	movr		sendData3_VTM,0
	xorar		V_RXROLL1,0
	btrss		zf
	clrr		V_PairTimeCT
	movr		sendData4_VTM,0
	xorar		V_RXROLL2,0
	btrss		zf
	clrr		V_PairTimeCT
	movr		sendData5_VTM,0
	xorar		V_RXROLL3,0
	btrss		zf
	clrr		V_PairTimeCT
RX_PAIR_FIRST_UPROLL:	
	movr 		sendData2_VTM,0
	movar		V_RXROLL0
	movr 		sendData3_VTM,0
	movar		V_RXROLL1
	movr 		sendData4_VTM,0
	movar		V_RXROLL2
	movr 		sendData5_VTM,0
	movar		V_RXROLL3
	lcall		UPDATA_RXCH
;//ACK roll signal
;//
	incr		V_PairTimeCT,1
	movia		8
	subar		V_PairTimeCT,0
	btrss		cf
	lgoto		RX_PAIR_TXROLL_NEXT1
RX_PAIR_FIRST:	
	clrr		V_PairTimeCT
	bcr			_flag_Build
	bcr			_flag_RF_Reset
	bsr			_flag_LRturnTrig
	clrr		Test_VTM
;//	lgoto		RX_WAIT_NEXT
RX_PAIR_TXROLL_NEXT1:	
	movia		0x79
	movar		sendData0_VTM
	movr 		V_RXROLL0,0
	movar		sendData1_VTM
	movr		V_RXROLL1,0
	movar		sendData2_VTM
	movr		V_RXROLL2,0
	movar		sendData3_VTM
	movr		V_RXROLL3,0
	movar		sendData4_VTM
	lcall		ROLL0
	movar		sendData5_VTM
	lcall		ROLL1
	movar		sendData6_VTM
	lcall		ROLL2
	movar		sendData7_VTM
	lcall		ROLL3
	movar		sendData8_VTM
	lgoto		MAIN_TX_NOR_SEND
RX_TXDATA_CK:
	movr 		V_RXROLL0,0
	xorar		sendData2_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	movr 		V_RXROLL1,0
	xorar		sendData3_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	movr 		V_RXROLL2,0
	xorar		sendData4_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	movr 		V_RXROLL3,0
	xorar		sendData5_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	btrss		_flag_Build
	lgoto		RX_TXDATA_CK_DECODE
RX_PAIR_FIRST_JUAGE:
	movr		V_PairTimeCT,0
	btrss		zf
	lgoto		RX_PAIR_FIRST
	bcr			_flag_Build
	bcr			_flag_RF_Reset
	lgoto		RX_WAIT_NEXT
RX_TXDATA_CK_DECODE:
	movr 		sendData1_VTM,0
	xoria		0x3c
	btrss		zf
	lgoto		RX_WAIT_NEXT
	clrr		V_lostT
	clrr		V_lost1T
	bsr			_flag_lostcode
	bcr			_flag_ScanMode
	movr 		sendData0_VTM,0
	xorar		V_WorkST,0
	btrsc		zf
	lgoto		RX_WAIT_NEXT
	movr		sendData0_VTM,0
	movar		V_WorkST	
	clrr		V_system1T
	lgoto		RX_WAIT_NEXT
else
	movia		0x79
	xorar		sendData0_VTM,0
	btrss		zf 
	lgoto		RX_WAIT_NEXT

	lcall		ROLL0
	xorar		sendData1_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	lcall		ROLL1
	xorar		sendData2_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	lcall		ROLL2
	xorar		sendData3_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
	lcall		ROLL3
	xorar		sendData4_VTM,0
	btrss		zf
	lgoto		RX_WAIT_NEXT
endif
RX_PAIR_ROLL:
	bcr 		_flag_Build 
	bcr			_flag_RF_Reset
RX_PAIR_ROLL_NEXT:	
	movr 		sendData5_VTM,0
	movar		V_RXROLL0
	movr 		sendData6_VTM,0
	movar		V_RXROLL1
	movr 		sendData7_VTM,0
	movar		V_RXROLL2
	movr 		sendData8_VTM,0
	movar		V_RXROLL3
	lcall		UPDATA_RXCH
RX_WAIT_NEXT:
if C_MODE_RX_En
	lcall		EN_RX_MODE
else
	lcall		RF_IDLE_MODE
	lcall		CLR_W_FIFO
	lcall		CLR_R_FIFO
endif
	lgoto		MAIN_LOOP

TX_WAIT_DELAY:
	lcall		DELAY_4ms 
	lcall		DELAY_500us
	lgoto		MAIN_LOOP
;//********************************************
;//scan peak
;//*********************************************
SCAN_PEAK:
	movia		RFStatus_CTM
	lcall		SPI_R
	lcall		SPI_R_DATA
	bsr			PIN_CSN 
	movia		0x5e
	andar		TempData_VTM,1
	rlr 		RFValue_VTM,0
	andia		0x1e
	ioria 		0x40
	xorar 		TempData_VTM,0
	ret		

;//*******************************************
;//ROLL 0-3 -> TXCH
UPDATA_TXCH:
	lcall		ROLL0 
	movar		sendData0_VTM
	lcall		ROLL1 
	movar		sendData1_VTM
	lcall		ROLL2 
	movar		sendData2_VTM
	lcall		ROLL3 
	movar		sendData3_VTM
	movia 		Addr_TXCH
	movar 		sendData6_VTM
   	lcall		ROLL_CHANNEL
	movr 		sendData7_VTM,0
	movar		TXCH0_VTM
	movr 		sendData8_VTM,0
	movar		TXCH1_VTM
	movr 		sendData9_VTM,0
	movar		TXCH2_VTM
	ret
;//******************************************
;//ROLL 0-3 -> RXCH
UPDATA_RXCH:
	movr 		V_RXROLL0,0
	movar		sendData0_VTM
	movr 		V_RXROLL1,0
	movar		sendData1_VTM
	movr		V_RXROLL2,0
	movar		sendData2_VTM
	movr		V_RXROLL3,0
	movar		sendData3_VTM
	movia 		Addr_RXCH
	movar 		sendData6_VTM
   	lcall		ROLL_CHANNEL
	movr 		sendData7_VTM,0
	movar		RXCH0_VTM
	movr 		sendData8_VTM,0
	movar		RXCH1_VTM
	movr 		sendData9_VTM,0
	movar		RXCH2_VTM
	ret
if C_MODE_RX_En
SCAN_MODE:
	incr 		V_lostT,1
	movr		V_lostT,0
	subia		100	;//100ms
	btrsc		cf
	lgoto		SCAN_MODE_END
	clrr		V_lostT
	btrsc		_flag_lostcode
	lgoto		SCAN_MODE_NEXT
	movia		0x40	;// _flag_ScanMode
	xorar		V_Workflag,1
SCAN_MODE_NEXT:
	lcall		RF_CHANNEL_CHOICE
	lcall		RF_IDLE_MODE
	lcall		RF_SCR_REG
	lcall		EN_RX_MODE
	incr		V_lost1T,1
	btrss		V_lost1T,3
	lgoto		SCAN_MODE_END
	clrr		V_lost1T
	clrr		V_WorkST
	bcr			_flag_lostcode
	bcr			_flag_RF_Reset
SCAN_MODE_END:
	ret
endif