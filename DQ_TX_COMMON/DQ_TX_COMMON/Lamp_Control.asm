ifndef __LAMP_CONTROL
#define __LAMP_CONTROL

;//#include	F_RFSPI.h
;// =========================================================================      
;// Project:       
;// File:          Lamp_Control.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/17
;// ========================================================================= 

LAMP_CONTROL:
if C_MODE_RX_En
	btrsc		_flag_Build
	lgoto		LAMP_CONTROL_OFF	;LAMP_CONTROL_BUILD_BLINK
    btrss       _flag_lostcode 
    lgoto       LAMP_CONTROL_OFF	;LAMP_CONTROL_LOST_BLINK
    btrss       V_WorkST,_F
    lgoto       LAMP_CONTROL_OFF
    lgoto		LAMP_CONTROL_ON
LAMP_CONTROL_LOST_BLINK:
	btrsc       V_systemT,6
    lgoto       LAMP_CONTROL_ON
    lgoto		LAMP_CONTROL_OFF
else 
if C_DK071  ;//enable DK071
    btrss       V_Key,_T 
    bcr         PIN_TULamp
    btrsc       V_Key,_T 
    bsr         PIN_TULamp
endif 
if C_TestMode_En	;//test mode enable
	btrss		_flag_Test
	lgoto		LAMP_CONTROL_NOR_DISPLAY
	btrss		ChannelCount_VTM,1
	lgoto		LAMP_TEST_DISPLAY1
	btrss		ChannelCount_VTM,0
	lgoto		LAMP_TEST_DISPLAY2
LAMP_TEST_DISPLAY3:	;//1.1s blink three
	btrsc		V_systemT,6	;//64*7 = 560ms?
	lgoto		LAMP_TEST_DISPLAY11
	lgoto		LAMP_TEST_DISPLAY12
LAMP_TEST_DISPLAY2:	;//1.1s blink two
	btrsc		V_systemT,6	;//64*7 = 560ms?
	lgoto		LAMP_CONTROL_OFF
	lgoto		LAMP_TEST_DISPLAY12
LAMP_TEST_DISPLAY1:	;//1.1s blink once
	btrsc		V_systemT,6	;//64*7 = 560ms?
	lgoto		LAMP_CONTROL_OFF
LAMP_TEST_DISPLAY11:
	btrsc		V_systemT,5
	lgoto		LAMP_CONTROL_OFF
LAMP_TEST_DISPLAY12:
	btrss		V_systemT,4
	lgoto		LAMP_CONTROL_ON
	lgoto		LAMP_CONTROL_OFF
LAMP_CONTROL_NOR_DISPLAY:
endif
    btrsc       _flag_BuildLED  
    lgoto       LAMP_CONTROL_BUILD_BLINK
    movr        V_Key,0
    andia       C_LRFB
    btrsc       zf
    lgoto       LAMP_CONTROL_OFF
endif
LAMP_CONTROL_ON:
    bsr         PIN_Lamp
    lgoto       LAMP_CONTROL_END
LAMP_CONTROL_BUILD_BLINK:
    btrsc       V_systemT,5	;//7*32 = 220ms?
    lgoto       LAMP_CONTROL_ON
LAMP_CONTROL_OFF:
    bcr         PIN_Lamp
LAMP_CONTROL_END:
    ret




endif __LAMP_CONTROL