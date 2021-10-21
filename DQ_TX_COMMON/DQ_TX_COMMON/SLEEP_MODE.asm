ifndef __SLEEP_MODE
#define __SLEEP_MODE
;// =========================================================================      
;// Project:       
;// File:           SLEEP_MODE.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:           2021/7/19
;// ========================================================================= 

SCAN_SLEEP:
    btrss       _flag_sleep
    lgoto       SCAN_SLEEP_END
if C_MODE_RX_En
    bcr         PIN_LAMP
    clrr        V_MotorFB
    bcr         PIN_MF
    bcr         PIN_MB
    bcr         PIN_ML
    bcr         PIN_MR
    lcall       RF_IDLE_MODE
    lcall       RF_MIS_REG
    clrwdt
    bcr         PCON,7
;//SLEEPING_RE:
;//    movr        V_Key,0
;//    movar       sendData9_VTM

else
    bcr         PIN_LAMP
    bcr         PIN_TULamp
    lcall       RF_IDLE_MODE
    lcall       RF_MIS_REG
    clrwdt
    bsr         INTE,1
    bcr         PCON,7
SLEEPING_RE:
    movr        V_Key,0
    movar       sendData9_VTM
endif
SLEEPING:
    movia       0
    movar       INTF 
    sleep
    nop
WAKE_CHECK:
if C_MODE_RX_En
    lgoto       SLEEPING
else
    clrr        Delay_VTM
WAKE_CHECK_LOOP:
    lcall       SCAN_BUTTON
    lcall       DELAY_4ms
    incr        Delay_VTM,1
    btrss       Delay_VTM,4 ;//64ms?
    lgoto       WAKE_CHECK_LOOP
    movr        V_Key,0
    xorar       sendData9_VTM,0
    btrsc       zf 
    lgoto       SLEEPING
if C_DK071  ;//enable DK071
	bsr			_flag_BuildL
	bcr			_flag_Build
	bcr			_flag_BuildLED
else
    btrss       V_Key,_T   
    lgoto       SLEEPING_RE
    bcr         _flag_RF_Reset
    bsr         _flag_Build
    bsr         _flag_BuildLED
    bcr         _flag_Start
    bcr			_flag_BuildL
endif                 
    clrr        V_system1T
    clrr        V_systemT
    bcr         _flag_sleep
    bcr         PIN_CSN
    lcall       DELAY_4ms
    bsr         PIN_CSN
    lcall       DELAY_4ms
endif
SCAN_SLEEP_END:
    ret

endif __SLEEP_MODE