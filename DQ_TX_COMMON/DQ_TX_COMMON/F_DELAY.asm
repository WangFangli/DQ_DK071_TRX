ifndef __F_DELAY
#define __F_DELAY

;//#include	F_RFSPI.h
;// =========================================================================      
;// Project:       
;// File:          F_DELAY.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/17
;// ========================================================================= 
DELAY_30ms:
    movia       60
    lgoto       DELAY_MS
DELAY_45ms:
    movia       90
    lgoto       DELAY_MS
DELAY_4ms:
    movia       8
    lgoto       DELAY_MS
DELAY_1ms:
    movia       2
    lgoto       DELAY_MS
DELAY_500us:
    movia       1
DELAY_MS:
    movar       ReadData_VTM
    clrr        WriteData_VTM
DELAY_LOOP:
    clrwdt
    decrsz      WriteData_VTM,1
    lgoto       DELAY_LOOP
    decrsz      ReadData_VTM,1
    lgoto       DELAY_LOOP
    ret 

endif __F_DELAY