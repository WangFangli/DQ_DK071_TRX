;=======================================================================================================================
;=======================================================================================================================
;File:			NY8A053D.h
;Description:	The Header File for NY8A053D
;Author:		JasonLee
;Date:			2017/05/23
;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
;MOVR and MOVAR instrutions for access R-page Register (General Purpose Register)
;-----------------------------------------------------------------------------------------------------------------------
;R-page sregisters				;	bit7	|	bit6	|	bit5	|	bit4	|	bit3	|	bit2	|	bit1	|	bit0
;-----------------------------------------------------------------------------------------------------------------------	
; 00H --------- Indirect Addressing Register
INDF				EQU		00H
Pr_Indir_Addr		EQU		00H
; 01H --------- Timer0 Data Register	
TMR0				EQU		01H
Pr_TMR0_Data		EQU		01H
; 02H --------- Low Byte of Program Counter
PCL					EQU		02H
Pr_PCLow_Data		EQU		02H
; 03H --------- Status Register
STATUS				EQU		03H
Pr_Status			EQU		03H	;	-			-			-			/WDT_TO		/Sleep		Z			Half_C		C	
; 04H --------- File Selection Register (Include SRAM Bank Select)
FSR					EQU		04H
Pr_File_Sel			EQU		04H	;	BK[1]		BK[0]		FSR[5]		FSR[4]		FSR[3]		FSR[2]		FSR[1]		FSR[0]	         
; 05H --------- PortA Data Register
PORTA				EQU		05H
Pr_PA_Data			EQU		05H
; 06H --------- PortB Data Register
PORTB				EQU		06H
Pr_PB_Data			EQU		06H
; 07H --------- Reserved
; 08H --------- Power Control Register (WatchDog, ExtINT and LVR Control)
PCON				EQU		08H
Pr_PWR_Ctrl			EQU		08H	;	WDTEn		ExtINTEn	-			-			LVREn		-			-			-	
; 09H --------- PortB Wakeup Control Register
BWUCON				EQU		09H
Pr_PB_WakeUp_Ctrl	EQU		09H
; 0AH --------- High Byte of Program Counter (B'xxxxxxDD')
PCHBUF				EQU		0AH
Pr_PCHigh_Data		EQU		0AH	;	-			XSPD_STP	-			-			-			-			PCHBUF[1]	PCHBUF[0]
; 0BH --------- PortA/B Pull-Low Control Register
ABPLCON				EQU		0BH
Pr_PAB_PL_Ctrl		EQU		0BH	;	/PB[3]		/PB[2]		/PB[1]		/PB[0]		/PA[3]		/PA[2]		/PA[1]		/PA[0]		
; 0CH --------- PortB Pull-High Control Register
BPHCON				EQU		0CH
Pr_PB_PH_Ctrl		EQU		0CH	;	/PB[7]		/PB[6]		/PB[5]		/PB[4]		-		    /PB[2]		/PB[1]		/PB[0]	
; 0DH --------- Reserved
; 0EH --------- Interrupt Enable Register
INTE				EQU		0EH
Pr_INT_Ctrl			EQU		0EH	;	-			WDT			-			-			TMR1		ExtINT		PBKey		TMR0	
; 0FH --------- Interrupt Flag	(Write '0' to Clear Flag)
INTF				EQU		0FH
Pr_INT_Flag			EQU		0FH	;	-			WDT			-			-			TMR1		ExtINT		PBKey		TMR0	

;-----------------------------------------------------------------------------------------------------------------------
;T0MD and T0MDR instrutions for access T0MD Register
;-----------------------------------------------------------------------------------------------------------------------
; xxH --------- Timer0 Control Register (Only Accessed by Instruction T0MD)
;T0MD				EQU		xxH	;	LClkSrc		INTEdge		ClkSel		EdgeSel		PS0WDT		PS0Div[2]	PS0Div[1]	PS0Div[0]	
;P_TMR0_Ctrl

;-----------------------------------------------------------------------------------------------------------------------
;IOST and IOSTR instrution for access F-page Register (IO Configuration Register)
;-----------------------------------------------------------------------------------------------------------------------
;F-page registers				;	bit7	|	bit6	|	bit5	|	bit4	|	bit3	|	bit2	|	bit1	|	bit0
;-----------------------------------------------------------------------------------------------------------------------	
; 05H --------- PortA Direction(1:Input/0:Output) Control Register
IOSTA				EQU		05H
Pf_PA_Dir_Ctrl		EQU		05H
; 06H --------- PortB Direction(1:Input/0:Output) Control Register
IOSTB				EQU		06H
Pf_PB_Dir_Ctrl		EQU		06H
; 0AH --------- Prescaler0 Counter Value Register
PS0CV				EQU		0AH
Pf_PS0_Cnt			EQU		0AH
; 0CH --------- PortB Open-Drain Control Register
BODCON				EQU		0CH
Pf_PB_OD_Ctrl		EQU		0CH	;	PB[7]		PB[6]		PB[5]		PB[4]		-  			PB[2]		PB[1]		PB[0]		
; 0FH --------- Power Control Register 1
PCON1				EQU		0FH
Pf_PWR_Ctrl1		EQU		0FH	;	INTEn		-			-			-			-			-			-			TMR0En	

;-----------------------------------------------------------------------------------------------------------------------
;SFUN and SFUNR instrution for access S-page Register (Special Function Register)
;-----------------------------------------------------------------------------------------------------------------------
;S-page registers				;	bit7	|	bit6	|	bit5	|	bit4	|	bit3	|	bit2	|	bit1	|	bit0
;-----------------------------------------------------------------------------------------------------------------------											
; 00H --------- Timer1 Data Register	
TMR1				EQU		00H
Ps_TMR1_Data		EQU		00H
; 01H --------- Timer1 Control Register	1
T1CR1				EQU		01H
Ps_TMR1_Ctrl1		EQU		01H	;	PWM1En		PWM1ActB	-			-			-			OneShot		Reload		TMR1En	
; 02H --------- Timer1 Control Register	2
T1CR2				EQU		02H
Ps_TMR1_Ctrl2		EQU		02H	;	-			-			ClkSel		EdgeSel		/PS1En		PS1Div[2]	PS1Div[1]	PS1Div[0]	
; 03H --------- PWM1 Duty Register
PWM1DUTY			EQU		03H
Ps_PWM1_Duty		EQU		03H
; 04H --------- Prescaler1 Counter Value Register
PS1CV				EQU		04H
Ps_PS1_Cnt			EQU		04H
; 05H --------- Buzzer1 Control Register
BZ1CR				EQU		05H
Ps_BZ1_Ctrl			EQU		05H	;	BZ1En		-			-			-			FSel[3]		FSel[2]		FSel[1]		FSel[0]	
; 06H --------- IR Control Register
IRCR				EQU		06H
Ps_IR_Ctrl			EQU		06H	;	IROSC358M   -			-			-			-			PolSel  	IRF57K		IREn	
; 07H --------- Table Access High Byte Address Pointer Register
TBHP				EQU		07H
Ps_TbHigh_Addr		EQU		07H	;	-			-			-			-		    -		    HPoint[2]	HPoint[1]	HPoint[0]	
; 08H --------- Table Access High Byte Data Register
TBHD				EQU		08H
Ps_TbHigh_Data		EQU		08H	;	-			-			HData[5]	HData[4]	HData[3]	HData[2]	HData[1]	HData[0]	
; 0FH --------- Oscillation Control Register (Include Switch Working Mode)
OSCCR				EQU		0FH
Ps_SYS_Ctrl			EQU		0FH	;	-			-			-			-			Mode[1]		Mode[0]		HOSC_Stop	HOSC_Sel

;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
; R-page Special Function Register (General Purpose Register)
;-----------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------
; Pr_Indir_Addr (00H)	--------- Indirect Addressing Register
;------------------------------------------------------------
;Bit[7:0] : Indirect Address
	C_Indir_Addr		EQU		FFH

;------------------------------------------------------------
; Pr_TMR0_Data (01H)	--------- Timer0 Data Register	
;------------------------------------------------------------
;Bit[7:0] : Timer0 Data
	C_TMR0_Data			EQU		FFH

;------------------------------------------------------------
; Pr_PCLow_Data (02H)	--------- Low Byte of Program Counter
;------------------------------------------------------------
;Bit[7:0] : Low Byte of Program Counter
	C_PCLow_Data		EQU		FFH

;------------------------------------------------------------
; Pr_Status (03H)		--------- Status Register
;------------------------------------------------------------
;Bit[7:5] : Reserved
;Bit[4:0] : System Status
	C_Status_WDT		EQU		10H			; WatchDog Overflow Flag
	C_Status_Slp		EQU		08H			; Sleep (Power Down) Flag
	C_Status_Z			EQU		04H			; Zero Flag
	C_Status_HalfC		EQU		02H			; Half Carry/Half Borrow Flag
	C_Status_C			EQU		01H			; Carry/Borrow Flag
	
	C_Status_WDT_Bit	EQU		4
	C_Status_Slp_Bit	EQU		3
	C_Status_Z_Bit		EQU		2
	C_Status_HalfC_Bit	EQU		1
	C_Status_C_Bit		EQU		0

;------------------------------------------------------------ 
; Pr_File_Sel (04H)		--------- File Selection Register (Include SRAM Bank Select)        
;------------------------------------------------------------
;Bit[7:6] : FSR Bit Define	
	C_SFR_Bank			EQU		C0H			; Select Ram Bank
	C_SFR_Bank0			EQU		00H			; Select Ram Bank0
	C_SFR_Bank1			EQU		40H			; Select Ram Bank1
	C_SFR_Bank2			EQU		80H			; Select Ram Bank2
	C_SFR_Bank3			EQU		C0H			; Select Ram Bank3	
;Bit[5:0] : Select one Register out of 64 registers of specific Bank.
	C_SFR_RAM_Addr		EQU		3FH			; RAM Address Bit[5:0] 

;------------------------------------------------------------	 
; Pr_PA_Data (05H)		--------- PortA Data Register
;------------------------------------------------------------
;Bit[7:4] : Reserved
;Bit[3:0] : PORTA Data Bit Define	
	C_PA_Data			EQU		0FH			; PA Data
	C_PA3_Data			EQU		08H			; PA3 Data
	C_PA2_Data			EQU		04H			; PA2 Data
	C_PA1_Data			EQU		02H			; PA1 Data
	C_PA0_Data			EQU		01H			; PA0 Data

;------------------------------------------------------------
; Pr_PB_Data (06H)		--------- PortB Data Register
;------------------------------------------------------------
;Bit[7:0] : PORTB Data Bit Define	
	C_PB_Data			EQU		FFH			; PB Data
	C_PB7_Data			EQU		80H			; PB7 Data
	C_PB6_Data			EQU		40H			; PB6 Data
	C_PB5_Data			EQU		20H			; PB5 Data
	C_PB4_Data			EQU		10H			; PB4 Data
	C_PB3_Data			EQU		08H			; PB3 Data
	C_PB2_Data			EQU		04H			; PB2 Data
	C_PB1_Data			EQU		02H			; PB1 Data
	C_PB0_Data			EQU		01H			; PB0 Data

;------------------------------------------------------------	
; Pr_PWR_Ctrl (08H)		--------- Power Control Register (WatchDog, ExtINT and LVR Control) 
;------------------------------------------------------------
;Bit[7] : WatchDog Eanble
	C_WDT_En			EQU		80H			; WatchDog Enable
;Bit[6] : External INT Eanble
	C_ExtINT_En			EQU		40H			; External INT Enable
;Bit[5:4] : Reserved
;Bit[3] : LVR Enable
	C_LVR_En			EQU		08H			; LVR Enable
;Bit[2:0] : Reserved
	
;------------------------------------------------------------	
; Pr_PB_WakeUp_Ctrl (09H)	--------- PortB Wakeup Control Register
;------------------------------------------------------------
;Bit[7:0] : BWUCON Bit Define
	C_PB_Wakeup			EQU		FFH			; PortB Wakeup Enable
	C_PB7_Wakeup		EQU		80H			; PB7 Wakeup Enable
	C_PB6_Wakeup		EQU		40H			; PB6 Wakeup Enable  
	C_PB5_Wakeup		EQU		20H			; PB5 Wakeup Enable
	C_PB4_Wakeup		EQU		10H			; PB4 Wakeup Enable
	C_PB3_Wakeup		EQU		08H			; PB3 Wakeup Enable
	C_PB2_Wakeup		EQU		04H			; PB2 Wakeup Enable 
	C_PB1_Wakeup		EQU		02H			; PB1 Wakeup Enable
	C_PB0_Wakeup		EQU		01H			; PB0 Wakeup Enable
		
;------------------------------------------------------------	
; Pr_PCHigh_Data (0AH) --------- High Byte of Program Counter
;------------------------------------------------------------
;Bit[7] : Reserved
;Bit[6] : E_LXT Buckup Contorl Bit	(1:Disable, 0:Enable)
	C_ELXT_Backup		EQU		40H	
;Bit[5:2] : Reserved
;Bit[1:0] : High Byte of Program Counter
	C_PCHigh_Data		EQU		03H
		
;------------------------------------------------------------		
; Pr_PAB_PL_Ctrl (0BH)	--------- PortA/B Pull-Low Control Register
;------------------------------------------------------------
;Bit[7:4] : PortB Pull-Low Control Register (1:Disable, 0:Pull-High)
    C_PB_PLB			EQU		F0H			; PortB Pull-Low Control bit
    C_PB3_PLB			EQU		80H			; PB3 Pull-Low Control bit
    C_PB2_PLB			EQU		40H			; PB2 Pull-Low Control bit	
    C_PB1_PLB			EQU		20H			; PB1 Pull-Low Control bit 	
    C_PB0_PLB			EQU		10H			; PB0 Pull-Low Control bit
;Bit[3:0] : PortA Pull-Low Control Register
    C_PA_PLB			EQU		0FH			; PortA Pull-Low Control bit
    C_PA3_PLB			EQU		08H			; PA3 Pull-Low Control bit
    C_PA2_PLB			EQU		04H			; PA2 Pull-Low Control bit	
    C_PA1_PLB			EQU		02H			; PA1 Pull-Low Control bit	
    C_PA0_PLB			EQU		01H			; PA0 Pull-Low Control bit

;------------------------------------------------------------	
; Pr_PB_PH_Ctrl (0CH)	--------- PortB Pull-High Control Register
;------------------------------------------------------------
;Bit[7:4]&Bit[2:0] : PortB Pull-High Control Register (1:Disable, 0:Pull-High)
;Bit[3] : Reserved
	C_PB_PHB			EQU		F7H			; PortB Pull-Low Control bit 
	C_PB7_PHB			EQU		80H			; PB7 Pull-Low Control bit 
	C_PB6_PHB			EQU		40H			; PB6 Pull-Low Control bit   
	C_PB5_PHB			EQU		20H			; PB5 Pull-Low Control bit
	C_PB4_PHB			EQU		10H			; PB4 Pull-Low Control bit
	C_PB2_PHB			EQU		04H			; PB2 Pull-Low Control bit
	C_PB1_PHB			EQU		02H			; PB1 Pull-Low Control bit
	C_PB0_PHB			EQU		01H			; PB0 Pull-Low Control bit

;------------------------------------------------------------	
; Pr_INT_Ctrl (0EH)		--------- Interrupt Enable Register
; Pr_INT_Flag (0FH)		--------- Interrupt Flag
;------------------------------------------------------------
;Bit[7] : Reserved
;Bit[6] : WatchDog Flag
	C_INT_WDT			EQU		40H			; WDT timeout interrupt enable bit
	C_INT_WDT_Bit		EQU		6

;Bit[5:4] : Reserved
;Bit[3:0] : Interrupt Source
	C_INT_TMR1			EQU		08H			; Timer1 underflow interrupt enable bit
	C_INT_EXT			EQU		04H			; External interrupt enable bit
	C_INT_PBKey			EQU		02H			; PortB input change interrupt enable bit
	C_INT_TMR0			EQU		01H			; Timer0 overflow interrupt enable bit 

	C_INT_TMR1_Bit		EQU		3
	C_INT_EXT_Bit		EQU		2
	C_INT_PBKey_Bit		EQU		1
	C_INT_TMR0_Bit		EQU		0

;------------------------------------------------------------	
; P_TMR0_Ctrl (xxH)		--------- T0MD Register
;------------------------------------------------------------
;		C_TMR0_Clk		C_TMR0_LowClk	|	Timer 0 Clock Source
;------------------------------------------------------------
;		0				x				|	From Instruction Clock
;		1				0				|	From External Pin
;		1				1				|	From Low Oscillator Frequency (I_LRC or E_LXT)
;------------------------------------------------------------
;Bit[7:4] : Timer0 Clock Source Selection
	C_TMR0_LowClk		EQU		80H			; Same as LCKTM0
	C_EXINT_Edge		EQU		40H			; External INT Edge Select --- 1:Rising Edge, 0:Falling Edge
	C_TMR0_Clk			EQU		20H			; Same as T0CS
	C_TMR0_ExtClk_Edge	EQU		10H			; Timer0 External Clock Edge Select --- 1:Falling Edge, 0:Rising Edge

;Bit[3] : Watchdog Interrupt Source Selection / Timer0 Prescaler0 Selection
	C_PS0_WDT			EQU		08H			; Prescaler0 is assigned to WDT
	C_PS0_TMR0			EQU		00H			; Prescaler0 is assigned to TMR0
;Bit[2:0] : Prescaler0 Dividing Rate Selection
	C_PS0_Div			EQU		07H			; Prescaler0 Dividing Rate Selection
	C_PS0_Div2			EQU		00H
	C_PS0_Div4			EQU		01H
	C_PS0_Div8			EQU		02H
	C_PS0_Div16			EQU		03H
	C_PS0_Div32			EQU		04H
	C_PS0_Div64			EQU		05H
	C_PS0_Div128		EQU		06H
	C_PS0_Div256		EQU		07H

;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
; F-page Special Function Register (IO Configuration Register)
;-----------------------------------------------------------------------------------------------------------------------	
;------------------------------------------------------------
; Pf_PA_Dir_Ctrl (05H)	--------- PortA Direction(Input/Output) Control Register
;------------------------------------------------------------
;Bit[7:4] : Reserved
;Bit[3:0] : Port A Input/Output Mode Selection (1:Input, 0:Output)
	C_PA_Input			EQU		0FH			; Port A Input Mode Control
	C_PA_Output			EQU		00H			; Port A Output Mode Control

	C_PA3_Input			EQU		08H			; PA3 I/O mode Control bit
	C_PA2_Input			EQU		04H			; PA2 I/O mode Control bit
	C_PA1_Input			EQU		02H			; PA1 I/O mode Control bit
	C_PA0_Input			EQU		01H			; PA0 I/O mode Control bit 
	C_PA3_Output		EQU		00H			; PA3 I/O mode Control bit
	C_PA2_Output		EQU		00H			; PA2 I/O mode Control bit
	C_PA1_Output		EQU		00H			; PA1 I/O mode Control bit
	C_PA0_Output		EQU		00H			; PA0 I/O mode Control bit 

;------------------------------------------------------------	
; Pf_PB_Dir_Ctrl (06H)	--------- PortB Direction(Input/Output) Control Register
;------------------------------------------------------------
;Bit[7:0] : Port B Input/Output Mode Selection (1:Input, 0:Output)
	C_PB_Input			EQU		FFH			; Port B Input Mode Control
	C_PB_Output			EQU		00H			; Port B Output Mode Control

	C_PB7_Input			EQU		80H			; PB7 I/O mode Control bit
	C_PB6_Input			EQU		40H			; PB6 I/O mode Control bit
	C_PB5_Input			EQU		20H			; PB5 I/O mode Control bit
	C_PB4_Input			EQU		10H			; PB4 I/O mode Control bit
	C_PB3_Input			EQU		08H			; PB3 I/O mode Control bit
	C_PB2_Input			EQU		04H			; PB2 I/O mode Control bit
	C_PB1_Input			EQU		02H			; PB1 I/O mode Control bit
	C_PB0_Input			EQU		01H			; PB0 I/O mode Control bit
	C_PB7_Output		EQU		00H			; PB7 I/O mode Control bit
	C_PB6_Output		EQU		00H			; PB6 I/O mode Control bit
	C_PB5_Output		EQU		00H			; PB5 I/O mode Control bit
	C_PB4_Output		EQU		00H			; PB4 I/O mode Control bit
	C_PB3_Output		EQU		00H			; PB3 I/O mode Control bit
	C_PB2_Output		EQU		00H			; PB2 I/O mode Control bit
	C_PB1_Output		EQU		00H			; PB1 I/O mode Control bit
	C_PB0_Output		EQU		00H			; PB0 I/O mode Control bit

;------------------------------------------------------------	
; Pf_PS0_Cnt (0AH)		--------- Prescaler0 Counter Value Register
;------------------------------------------------------------
;Bit[7:0] : Prescaler0 Counter Value
;	C_PS0_Cnt			EQU		FFH			; 8-Bit register	
	
;------------------------------------------------------------	
; Pf_PB_OD_Ctrl (0CH)	--------- PortB Open-Drain Control Register
;------------------------------------------------------------
;Bit[7:4]&Bit[2:0] : PortB Open-Drain Control (1:Open-Drain, 0:Disable)
;Bit[3] : Reserved
	C_PB_OD				EQU		F7H			; Port B Open-Drain Control
	C_PB7_OD			EQU		80H			; PB7 Open-Drain Control bit
	C_PB6_OD			EQU		40H			; PB6 Open-Drain Control bit 
	C_PB5_OD			EQU		20H			; PB5 Open-Drain Control bit
	C_PB4_OD			EQU		10H			; PB4 Open-Drain Control bit
	C_PB2_OD			EQU		04H			; PB2 Open-Drain Control bit
	C_PB1_OD			EQU		02H			; PB1 Open-Drain Control bit 
	C_PB0_OD			EQU		01H			; PB0 Open-Drain Control bit

;------------------------------------------------------------	
; Pf_PWR_Ctrl1 (0FH)	--------- Power Control Register 1
;------------------------------------------------------------
;Bit[7] : All Interrupt Enable
	C_All_INT_En		EQU		80H			; Enable all unmasked interrupts
;Bit[6:1] : Reserved
;Bit[0] : Timer0 Enable
	C_TMR0_En			EQU		01H			; Enable Timer0
	C_TMR0_Dis			EQU		00H			; Disable Timer0
		
;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
; S-page Special Function Register (Special Function Register)
;-----------------------------------------------------------------------------------------------------------------------		
;------------------------------------------------------------
; Ps_TMR1_Data (00H)	--------- Timer1 Data Register
;------------------------------------------------------------
;Bit[7:0] : Timer1 Data
	C_TMR1_Data			EQU		FFH	
	
;------------------------------------------------------------	
; Ps_TMR1_Ctrl1 (01H)	--------- Timer1 Control Register 1
;------------------------------------------------------------
;Bit[7:6] : PWM1 Control
	C_PWM1_En			EQU		80H 		; PWM1 output will be present on PB6
	C_PWM1_Active		EQU		40H 		; PWM1 output is active
	C_PWM1_Active_Lo	EQU		40H 		; PWM1 output is active low 
	C_PWM1_Active_Hi	EQU		00H 		; PWM1 output is active high 
;Bit[5:3] : Reserved
;Bit[2:0] : Timer1 Control
	C_TMR1_OneShot		EQU		04H 		; One-Shot mode. Timer1 will count once from the initial value to 0x00
	C_TMR1_Reload		EQU		02H 		; Initial value is reloaded from reload register TMR1(T1OS=0)

	C_TMR1_En			EQU		01H 		; Enable Timer1
	C_TMR1_Dis			EQU		00H 		; Disable Timer1

;------------------------------------------------------------	
; Ps_TMR1_Ctrl2 (02H)	--------- Timer1 Control Register	2
;------------------------------------------------------------
;Bit[7:6] : Reserved
;Bit[5] : Timer1 Clock Source Select
	C_TMR1_ClkSrc_Ext	EQU		20H			; Timer1 clock source from External Clock Input
	C_TMR1_ClkSrc_Inst	EQU		00H			; Timer1 clock source from Internal Instruction Clock

	
;Bit[4] : Timer1 external clock edge selection
    C_TMR1_ExtClk_Edge	EQU		10H			; Timer1 External Clock Edge Select --- 1:Falling Edge, 0:Rising Edge  
	C_TMR1_ExtFalling	EQU		10H			; Timer1 will decrease one while EX_CKI Falling Edge.
	C_TMR1_ExtRising	EQU		00H			; Timer1 will decrease one while EX_CKI Rising Edge.
;Bit[3] :  Disable/enable Prescaler1
    C_PS1_Dis           EQU		08H			; Enable Prescaler1
	C_PS1_EN			EQU		00H			; Disable Prescaler1
;Bit[2:0] : Prescaler 1 Dividing Rate Selection
	C_PS1_Div			EQU		07H			; Prescaler1 Dividing Rate Selection
	C_PS1_Div2			EQU		00H
	C_PS1_Div4			EQU		01H
	C_PS1_Div8			EQU		02H
	C_PS1_Div16			EQU		03H
	C_PS1_Div32			EQU		04H
	C_PS1_Div64			EQU		05H
	C_PS1_Div128		EQU		06H
	C_PS1_Div256		EQU		07H

;------------------------------------------------------------	
; Ps_PWM1_Duty (03H)	--------- PWM1 Duty Register
;------------------------------------------------------------
;Bit[7:0] : PWM1 Duty Value
	C_PWM1_Duty			EQU		FFH

;------------------------------------------------------------	
; Ps_PS1_Cnt (04H)		--------- Prescaler1 Counter Value Register
;------------------------------------------------------------
;Bit[7:0] : rescaler1 Counter Value
;	C_PS1_Cnt			EQU		FFH			; 8-Bit register	

;------------------------------------------------------------	
; Ps_BZ1_Ctrl (05H)		--------- Buzzer1 Control Register
;------------------------------------------------------------
;Bit[7] : BZ1 Enable
	C_BZ1_En			EQU		80H			; Enable BZ1 output
;Bit[6:4] : Reserved
;Bit[3:0] : BZ1 Frequency Selection
	C_BZ1_FSel			EQU		0FH			; BZ1 frequency selection

	C_BZ1_PS1Div2		EQU		00H			; Clock Soruce from Prescaler 1
	C_BZ1_PS1Div4		EQU		01H
	C_BZ1_PS1Div8		EQU		02H
	C_BZ1_PS1Div16		EQU		03H
	C_BZ1_PS1Div32		EQU		04H
	C_BZ1_PS1Div64		EQU		05H
	C_BZ1_PS1Div128		EQU		06H
	C_BZ1_PS1Div256		EQU		07H

	C_BZ1_TMR1B0		EQU		08H			; Clock Source from Timer 1
	C_BZ1_TMR1B1		EQU		09H
	C_BZ1_TMR1B2		EQU		0AH
	C_BZ1_TMR1B3		EQU		0BH
	C_BZ1_TMR1B4		EQU		0CH
	C_BZ1_TMR1B5		EQU		0DH
	C_BZ1_TMR1B6		EQU		0EH
	C_BZ1_TMR1B7		EQU		0FH

;------------------------------------------------------------	
; Ps_IR_Ctrl (06H)		--------- IR Control Register
;------------------------------------------------------------
;Bit[7] : IR Clock Source Selection (1:3.58M, 0:455KHz)
	C_IR_ClkSrc_358M	EQU		80H			; IRCR[7]=1 , external crystal is 3.58MHz (This bit is ignored if internal high frequency oscillation is used)
	C_IR_ClkSrc_455K	EQU		00H			; IRCR[7]=0 , external crystal is 455KHz
;Bit[6:3] : Reserved
;Bit[2] : IR Polarity Selection
	C_IR_Pol_Sel		EQU		04H
;Bit[1] : IR Carrier Frequency Selection (1:5.7K, 0:38KHz)
	C_IR_57K			EQU		02H			; IRCR[1]=1 , IR carrier frequency is 57KHz
	C_IR_38K			EQU		00H			; IRCR[1]=0 , IR carrier frequency is 57KHz
;Bit[0] : IR Enable
	C_IR_En				EQU		01H			; Enable IR carrier output

;------------------------------------------------------------	
; Ps_TbHigh_Addr (07H)	--------- Table Access High Byte Address Pointer Register
;------------------------------------------------------------
;Bit[7:2] : Reserved
;Bit[1:0] : Table Access High Byte Address Pointer
	C_TbHigh_Addr		EQU		03H			; When instruction CALLA, GOTOA or TABLEA is executed TBHP[1:0] is PC[9:8]

;------------------------------------------------------------	
; Ps_TbHigh_Data (08H)	--------- Table Access High Byte Data Register
;------------------------------------------------------------
;Bit[7:6] : Reserved
;Bit[5:0] : Table Access High Byte Data
	C_TbHigh_Data		EQU		3FH

;------------------------------------------------------------   
; Ps_SYS_Ctrl (0FH)	--------- Table Access High Byte Data Register
;------------------------------------------------------------
;Bit[7:4] : Reserved
;Bit[3:2] : System Mode Select
	C_Mode				EQU		0CH			; System Operating Mode Selection
	C_Normal_Mode		EQU		00H			; Enter Normal mode
	C_Halt_Mode			EQU		04H			; Enter Halt mode
	C_Standby_Mode		EQU		08H			; Enter Standby mode
;Bit[1] : Stop FHOSC
	C_FHOSC_Stop		EQU		02H			; Disable high-frequency oscillation (FHOSC)
;Bit[0] : FOSC Seletction
	C_FHOSC_Sel			EQU		01H			; OSCCR[0]=1 , FOSC is high-frequency oscillation (FHOSC)
	C_FLOSC_Sel			EQU		00H			; OSCCR[0]=0 , FOSC is Low-frequency oscillation (FLOSC)	



;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
;General Constant Define
;-----------------------------------------------------------------------------------------------------------------------
	C_SaveToAcc			EQU		00H	
	C_SaveToReg			EQU		01H	

	C_Bit0				EQU		01H
	C_Bit1				EQU		02H
	C_Bit2				EQU		04H
	C_Bit3				EQU		08H
	C_Bit4				EQU		10H
	C_Bit5				EQU		20H
	C_Bit6				EQU		40H
	C_Bit7				EQU		80H

	C_Num0				EQU		0
	C_Num1				EQU		1
	C_Num2				EQU		2
	C_Num3				EQU		3
	C_Num4				EQU		4
	C_Num5				EQU		5
	C_Num6				EQU		6
	C_Num7				EQU		7
	