ifndef __SCAN_BUTTON
#define __SCAN_BUTTON

;//#include	F_RFSPI.h
;// =========================================================================      
;// Project:       
;// File:          Scan_Button.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/16
;// ========================================================================= 

SCAN_BUTTON:
    clrr        TempData_VTM       
    btrss       PIN_F
    bsr         TempData_VTM,_F
    btrss       PIN_B
    bsr         TempData_VTM,_B
    btrss       PIN_L
    bsr         TempData_VTM,_L
    btrss       PIN_R 
    bsr         TempData_VTM,_R 
    btrss       PIN_TU 
    bsr         TempData_VTM,_T 
    movr        TempData_VTM,0
    xorar       V_LastKey,0
    btrss       zf 
    lgoto       SCAN_BUTTON_FAIL
    incr        V_KeyCount,1
    btrss       V_KeyCount,3    ;//32*cycle 47ms?
    lgoto       SCAN_BUTTON_END
    btrsc       _flag_Build
    lgoto       BUTTON_PAIR_MODE
    btrsc		_flag_BuildLED
    lgoto		BUTTON_PAIR_MODE
if C_TestMode_En
    btrss       _flag_test
    lgoto       BUTTON_NORMAL_ST
    btrsc       V_Key,_L 
	lgoto       BUTTON_NORMAL_PRO
    btrss       V_LastKey,_L
    lgoto       BUTTON_NORMAL_PRO
    lcall       RF_CHANNEL_CHOICE0
    lgoto       BUTTON_NORMAL_PRO
endif 
BUTTON_NORMAL_ST:
    movr        V_key,0
    andia       C_LRFB
    btrss       zf
    lgoto       BUTTON_PAIR_NEXT
    bcr         _flag_R
    movr        V_LastKey,0
    andia       C_LRFB
    xoria       C_R    
    btrsc       zf
    bsr         _flag_R
    clrr        V_PairCount


;    btrsc       V_Key,_R
;    lgoto       BUTTON_PAIR_NEXT
;    bcr         _flag_R
;    btrsc       V_LastKey,_R
;    bsr         _flag_R      
;    clrr        V_PairCount      
BUTTON_PAIR_NEXT:
    movr        V_LastKey,0
    andia       C_LRFB
    xoria       C_R
    btrsc       zf
    lgoto       BUTTON_PAIR_NEXT1
    bcr         _flag_R
    lgoto       BUTTON_NORMAL_PRO

BUTTON_PAIR_NEXT1:    
    btrss       _flag_R
    lgoto       BUTTON_NORMAL_PRO
    incr        V_PairCount,1   ;//3s?
    btrss       V_PairCount,6 
    lgoto       BUTTON_UPDATA 
    bsr         _flag_BuildLED
    bsr         _flag_Build   
    bsr			_flag_BuildL
    bcr         _flag_RF_Reset
    bcr         _flag_R
    clrr        V_systemT
    clrr        V_system1T
BUTTON_NORMAL_PRO:
    movr        V_Key,0
    xorar       V_LastKey,0
    btrsc       zf
    lgoto       BUTTON_UPDATA
    clrr		V_systemT
	clrr		V_system1T   ;//have button press
BUTTON_UPDATA:
   
    movr        V_LastKey,0
    movar       V_Key
SCAN_BUTTON_FAIL:
    movr        TempData_VTM,0
    movar       V_LastKey
    clrr        V_KeyCount
SCAN_BUTTON_END:
    ret
BUTTON_PAIR_MODE:
    movr        V_Key,0
    andia       C_LRFB
    btrss       zf
    lgoto       BUTTON_UPDATA
    movr        V_LastKey,0
    andia       C_LRFB
    btrsc       zf
    lgoto       BUTTON_UPDATA
    bcr         _flag_BuildLED
    bcr         _flag_R
    clrr        V_PairCount
;//    bcr         _flag_Build
    lgoto       BUTTON_UPDATA    





endif __SCAN_BUTTON