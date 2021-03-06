ifndef __MOTOR
#define __MOTOR

;// =========================================================================      
;// Project:       
;// File:         MOTOR.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/17
;// ========================================================================= 
if C_DK071
#define 	C_speed		0	;//DK071:V0-6; V1-5; DK068:V2-8?
else
#define 	C_speed		2	;//->DK068
endif

#define 	C_M_MAX		16

switch C_speed
case 0
#define 	C_M_MIN		9	;//6 5 4	
break
case 1
#define 	C_M_MIN		5
break
default
#define 	C_M_MIN		9	;//->DK068
break;
endsw

#define     C_M_SLOWMIN     9   ;//12.5%


#define     C_SLOW_Time     89  ;//25min?
#define  	C_SLOW_STOP_Time	229	;179	;50min?
;//********************************************************
MOTOR_CONTROL:
    btrsc       _flag_FB_Brake
    lgoto       MOTOR_FB_BRAKE_ING
    movr        V_WorkST,0
    andia       C_FB
    btrsc       zf
    lgoto       MOTOR_FB_STOP      
    btrsc       V_WorkST,_B 
    lgoto       MOTOR_B        
MOTOR_F:
    btrss       _flag_FB_Stop
    lgoto       MOTOR_F_ING
    btrsc       _flag_FB 
    lgoto       MOTOR_FB_BRAKE
MOTOR_F_ING:   
    movia       C_M_MAX	;//15
    btrss       V_WorkST,_T 
    movia       C_M_MIN		;//9
    movar       TempData_VTM
    bcr         _flag_FB 
    lgoto       MOTOR_FB_ING
MOTOR_B:
    btrss       _flag_FB_Stop
    lgoto       MOTOR_B_ING
    btrss       _flag_FB 
    lgoto       MOTOR_FB_BRAKE
MOTOR_B_ING: 
    movia       C_M_MIN	;//C_M_MAX	;//15
    movar       TempData_VTM
    bsr         _flag_FB 
MOTOR_FB_ING:
	clrr		V_slow_v
if C_DK071==1
    btrss       _flag_FB_SLOW    
    bsr         _flag_FB_RUN	;int count
    btrsc       _flag_FB_SLOW 
    bcr         _flag_FB_RUN
    movia       C_SLOW_STOP_Time	;C_SLOW_Time  ;//
    subar       V_time2,0 
    btrsc       cf 
    bsr         _flag_FB_SLOW	;180?
    
    movia		C_SLOW_Time
    subar		V_time2,0
    btrss		cf
    lgoto		MOTOR_SLOW_NEXT
    movar		ReadData_VTM	
    clrwdt
MOMTOR_SLOW_LOOP:    
    incr		V_slow_v,1
    movia		8
    subar		ReadData_VTM,1
    btrsc		cf
    lgoto		MOMTOR_SLOW_LOOP
MOTOR_SLOW_NEXT:
endif

    clrr        V_FBTime
    bsr         _flag_FB_Stop
if C_DK071==1    
;    btrss       _flag_FB_SLOW
;    lgoto       MOTOR_FB_OUT_NOR
	movr		V_slow_v,0
	btrsc		zf
	lgoto		MOTOR_FB_OUT_NOR
    movr        V_FBStartRun,0
    xoria       0xff 
    btrss       zf 
    incr        V_FBStartRun,1    

    movia       8
    subar       V_FBStartRun,0
    btrss       cf 
    lgoto       MOTOR_FB_ING1  
    movia       20
    subar       V_FBStartRun,0
    btrss       cf 
    lgoto       MOTOR_FB_OUT_NOR1 
    
    movr		V_slow_v,0
    subar		TempData_VTM,0
    btrss		cf 
    lgoto		MOTOR_FB_OUT_SLOW_MIN
    movar		TempData_VTM
    movia		C_M_SLOWMIN
    subar		TempData_VTM,0
    btrss		cf 
    lgoto		MOTOR_FB_OUT_SLOW_MIN
    
;    swapr       V_FBStartRun,0
;    andia       0x0f 
;    subar       TempData_VTM,0
;    btrss       cf 
;    lgoto       MOTOR_FB_OUT_SLOW_MIN
;    movar       TempData_VTM
    
;    movia       C_M_SLOWMIN
;    subar       TempData_VTM,0
;    btrss       cf 
;    lgoto       MOTOR_FB_OUT_SLOW_MIN
    movr        TempData_VTM,0
    movar       V_MotorFB
    lgoto       MOTOR_FB_END
MOTOR_FB_OUT_SLOW_MIN:   
    movia       C_M_SLOWMIN
    movar       V_MotorFB
    lgoto       MOTOR_FB_END
endif
MOTOR_FB_OUT_NOR:
    incr        V_FBStartRun,1
    btrss       V_FBStartRun,3
    lgoto       MOTOR_FB_ING1       
    clrr        V_FBStartRun
MOTOR_FB_OUT_NOR1:    
    movr		TempData_VTM,0
    subar		V_MotorFB,0
    movr		TempData_VTM,0
    btrss       cf    
    incr        V_MotorFB,0
    movar		V_MotorFB	
    
MOTOR_FB_ING1:    
    movr        V_MotorFB,0
    subia       C_M_MIN
    btrss       cf
    lgoto       MOTOR_FB_END
    movia       C_M_MIN
    movar       V_MotorFB
    lgoto       MOTOR_FB_END
MOTOR_FB_BRAKE:
    movia       C_M_MAX	;//10
    movar       V_MotorFB
    clrr        V_FBTime
    bsr         _flag_FB_Brake
    bsr         PIN_MF
    bsr         PIN_MB 
    lgoto       MOTOR_FB_END
MOTOR_FB_BRAKE_ING:
    incr        V_FBTime,1
    btrss       V_FBTime,4
    lgoto       MOTOR_FB_END
    lgoto       MOTOR_FB_STOP_ING
MOTOR_FB_STOP:
if C_DK071==1
    bcr         _flag_FB_RUN
    btrsc       _flag_FB_SLOW
    clrr        V_FBStartRun
endif
    incr        V_FBTime,1
    movia       80
    subar       V_FBTime,0
    btrss       cf
    lgoto       MOTOR_FB_STOP_ING1
MOTOR_FB_STOP_ING:
    clrr        V_FBStartRun
    bcr         _flag_FB_Brake
    bcr         _flag_FB_Stop
    clrr        V_FBTime
MOTOR_FB_STOP_ING1:    
    clrr        V_MotorFB
    bcr         PIN_MF
    bcr         PIN_MB 
    
MOTOR_FB_END:
MOTOR_LR:
	btrss		_flag_LRturnTrig
	lgoto		MOTOR_LR_NOR
	incr		Test_VTM,1	;//->7ms?
	movia		60
	subar		Test_VTM,0
	btrss		cf
	lgoto		MOTOR_L
	movia		120
	subar		Test_VTM,0
	btrss		cf
	lgoto		MOTOR_R
	clrr		Test_VTM
	bcr			_flag_LRturnTrig
MOTOR_LR_NOR:	
    btrsc       V_WorkST,_L 
    lgoto       MOTOR_L
    btrsc       V_WorkST,_R 
    lgoto       MOTOR_R 
MOTOR_LR_STOP:
    bcr         PIN_ML 
    bcr         PIN_MR 
    ret
MOTOR_L:
    bcr         PIN_MR 
    bsr         PIN_ML 
    ret
MOTOR_R:
    bcr         PIN_ML 
    bsr         PIN_MR 
    ret
endif __MOTOR