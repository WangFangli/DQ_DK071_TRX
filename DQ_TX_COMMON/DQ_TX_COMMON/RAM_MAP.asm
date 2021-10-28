;//*******************************
;//RAM map set
;//*******************************
#define cf              STATUS,0       
#define zf              STATUS,2        

#define	HeadRAM_ADR	   	0x10
#define DataRAM_ADR     0x10
#define	EndRAM_ADR 	   	0x3f

#define RX_addr			HeadRAM_ADR+32
#define TX_addr 		HeadRAM_ADR+32

#define Addr_TXCH       0x1a    ;//CH addr
#define Addr_RXCH       0x1d    ;//CH addr

cblock	HeadRAM_ADR	;//bacnk0 0x10-0x3f,bank1 0x10-0x1f(32+16=48)
sendData0_VTM
sendData1_VTM
sendData2_VTM
sendData3_VTM
sendData4_VTM
sendData5_VTM
sendData6_VTM
sendData7_VTM
sendData8_VTM   ;//9?
sendData9_VTM   ;//10?

TXCH0_VTM
TXCH1_VTM
TXCH2_VTM

RXCH0_VTM
RXCH1_VTM
RXCH2_VTM

V_RXROLL0
V_RXROLL1
V_RXROLL2
V_RXROLL3   ;//20?

V_Workflag
V_Workflag1
TempData_VTM
Temp_VTM
Delay_VTM
WriteData_VTM
ReadData_VTM
RFValue_VTM
ChannelCount_VTM
Test_VTM
V_systemT
V_system1T	;//12+20 = 32+0x10 = 0x30
endc

if C_MODE_RX_En
cblock	RX_addr	
V_system0T
V_CountPWM
V_MotorFB
V_WorkST
V_FBTime
V_FBStartRun
V_lostT
V_lost1T
V_PairTimeCT
INTStatus_VTM
INTW_VTM    ;//->11?

V_time0
V_time1
V_time2	;//32+11+3 = 45
V_slow_v
endc

else
cblock	TX_addr	
V_KeyCount
V_Key
V_LastKey
V_PairCount ;//pair count time
endc
endif


#define _flag_Build		V_Workflag,0
#define _flag_BuildLED  V_Workflag,1
#define _flag_RF_Reset  V_Workflag,2
#define _flag_test      V_Workflag,3
#define _flag_Carrier   V_Workflag,4
#define _flag_sleep     V_Workflag,5

if C_MODE_RX_En
#define _flag_ScanMode  V_Workflag,6
else
#define _flag_R         V_Workflag,6
endif

if C_MODE_RX_En
#define _flag_lostcode  V_Workflag,7
else
#define _flag_Start     V_Workflag,7
endif

if C_MODE_RX_En
#define _flag_FB		V_Workflag1,0
else
#define _flag_BuildL	V_Workflag1,0
endif
#define _flag_FB_Stop 	V_Workflag1,1
#define _flag_FB_Brake 	V_Workflag1,2
#define _flag_LRturnTrig	V_Workflag1,3
if C_MODE_RX_En
#define  _flag_FB_RUN       V_Workflag1,4   
#define _flag_FB_SLOW       V_Workflag1,5   ;//FB over time slow speed     
endif