ifndef __TEST_MODE_ENTER
#define __TEST_MODE_ENTER

;//#include	F_RFSPI.h
;// =========================================================================      
;// Project:       
;// File:          Test_mode_enter.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/17
;// ========================================================================= 

if C_TestMode_En
TESTMODE_ENTER:
;if C_DK071  ;//enable DK071
;    btrss       V_Key,_T 
;    bcr         PIN_TULamp
;    btrsc       V_Key,_T 
;    bsr         PIN_TULamp
;endif 
    movia       100
    movar       Delay_VTM
TESTMODE_LOOP:
    lcall       SCAN_BUTTON
    lcall       DELAY_1ms 
    decrsz      Delay_VTM,1
    lgoto       TESTMODE_LOOP
    movr        V_Key,0
    andia       C_LF
    xoria		C_LF
    btrss       zf
    lgoto       TESTMODE_STEP0
    bsr         _flag_test
    movia		1
    movar		ChannelCount_VTM
    lgoto       TESTMODE_ENTER_END
TESTMODE_STEP0:
    movr        V_Key,0
    andia       C_LB
    xoria		C_LB
    btrss       zf 
    lgoto       TESTMODE_ENTER_END
    bsr         _flag_Carrier
    bsr         _flag_test
TESTMODE_ENTER_END:
    ret

endif
endif __TEST_MODE_ENTER