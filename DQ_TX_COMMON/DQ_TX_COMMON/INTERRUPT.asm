ifndef __INTERRUPT
#define __INTERRUPT

;// =========================================================================      
;// Project:       
;// File:          INTERRUPT.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/17
;// ========================================================================= 

;//--------------- Interrupt Service Routine --------------------------------
;//--------------------------------------------------------------------------
INTERRUPT:
if C_MODE_RX_En
		movar  	   	INTW_VTM
   	   	swapr 	   	STATUS,0
   	   	movar  	   	INTStatus_VTM

		movr 		V_MotorFB,0
		subar		V_CountPWM,0
		btrsc		cf
		lgoto		INT_MFB_STOP
		btrsc		_flag_FB
		bsr			PIN_MB 
		btrss		_flag_FB 
		bsr			PIN_MF
		lgoto		INT_PWM_COUNT
INT_MFB_STOP:
		bcr			PIN_MF
		bcr			PIN_MB
INT_PWM_COUNT:
		incr		V_CountPWM,1
		movia		0x0f
		andar		V_CountPWM,1
if DE_SPEED==1
		btrss		_flag_FB_RUN
		lgoto		INTERRUPT_END
		incr		V_time0,1
		btrsc		zf 
		incr		V_time1,1
		btrsc		zf 
		incr		V_time2,1
endif
INTERRUPT_END:
		clrr   	   	INTF
   	   	swapr 	    INTStatus_VTM,0
   	   	movar  	   	STATUS
   	   	swapr  	   	INTW_VTM,1
   	   	swapr 	   	INTW_VTM,0
endif 
		retie								;// Return from interrupt and enable interrupt globally


endif __INTERRUPT