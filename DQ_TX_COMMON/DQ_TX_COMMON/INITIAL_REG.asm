ifndef __INITIAL_REG
#define __INITIAL_REG

;// =========================================================================      
;// Project:       
;// File:         INITIAL_REG.asm
;// Description:   
;//                 
;// Author:     	WangFangli   
;// Version:    	V1.0.0   
;// Date:         2021/7/17
;// ========================================================================= 

;//**********************************************************
;// clear SRAM
;//**********************************************************
CLEAR_SRAM:
   movia    HeadRAM_ADR
   movar    FSR 
   clrr     INDF
   movr     FSR,0
   subia    EndRAM_ADR 
   btrsc    zf 
   lgoto	$+3 
   incr     FSR,1 
   lgoto    $-6 
   ret

;//**********************************************************
;// IC initial
;//usb 12bit sample -> 8bit data ->output 8bit PWM
;//**********************************************************
INITIAL_ROUTINE:
   disi                            ;// Disable all interrupt
   movia	   0x01
   sfun	   osccr
   movia    0x00    	;//TMR2 INT enable 
   movar    INTE                 ;//TMR0 INT all off
   movia    0x00                 ;//10/256=39,062,5HZ = 25.6us 
   T0MD 
   movia	   0x00
   movar	   TMR0
   movia    0  
   movar    INTF			;//interrupt flag 
   movia	   0x01
   iost	   PCON1

;//IO set ****************************************
   movia    PADR_SET
   movar    Porta
   movia    PBDR_SET
   movar    Portb
   movia    PAIO_SET
   iost     Porta               ;//pa4,pa3,pa0 output
   movia    PBIO_SET
   iost     Portb

   movia    PBPU_SET
   movar    BPHCON
   movia    PCON_SET
   movar    PCON

   movia    PBWU_SET
   movar	   BWUCON
   ret 

endif ;//__INITIAL_REG