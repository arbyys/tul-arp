PROCESSOR 16F1508 

#define	BT1	PORTA,4
#define	BT2	PORTA,5
; window -> TMW -> conf. bits -> ctl c ctr v
; CONFIG1
CONFIG  FOSC = INTOSC         ; Oscillator Selection Bits (INTOSC oscillator: I/O function on CLKIN pin)
CONFIG  WDTE = OFF            ; Watchdog Timer Enable (WDT disabled)
CONFIG  PWRTE = OFF           ; Power-up Timer Enable (PWRT disabled)
CONFIG  MCLRE = ON            ; MCLR Pin Function Select (MCLR/VPP pin function is MCLR)
CONFIG  CP = OFF              ; Flash Program Memory Code Protection (Program memory code protection is disabled)
CONFIG  BOREN = ON            ; Brown-out Reset Enable (Brown-out Reset enabled)
CONFIG  CLKOUTEN = OFF        ; Clock Out Enable (CLKOUT function is disabled. I/O or oscillator function on the CLKOUT pin)
CONFIG  IESO = ON             ; Internal/External Switchover Mode (Internal/External Switchover Mode is enabled)
CONFIG  FCMEN = ON            ; Fail-Safe Clock Monitor Enable (Fail-Safe Clock Monitor is enabled)

; CONFIG2
CONFIG  WRT = OFF             ; Flash Memory Self-Write Protection (Write protection off)
CONFIG  STVREN = ON           ; Stack Overflow/Underflow Reset Enable (Stack Overflow or Underflow will cause a Reset)
CONFIG  BORV = LO             ; Brown-out Reset Voltage Selection (Brown-out Reset Voltage (Vbor), low trip point selected.)
CONFIG  LPBOR = OFF           ; Low-Power Brown Out Reset (Low-Power BOR is disabled)
CONFIG  LVP = ON              ; Low-Voltage Programming Enable (Low-voltage programming enabled)

#include <xc.inc> 
  
;VARIABLE DEFINITIONS
;COMMON RAM 0x70 to 0x7F
tmp	EQU 0x70

    
;**********************************************************************
PSECT PROGMEM0,delta=2, abs

RESETVEC:
    ORG		0x00 
    PAGESEL	Start
    GOTO	Start
	
    ORG		0x04
    nop
    retfie
	
	
	
Start:	
    movlb	1		;Banka1
    movlw	01101000B	;4MHz Medium
    movwf	OSCCON		;nastaveni hodin

    call	Config_IOs

    ;config TMR2
    movlb	0		;Banka0 s TMR2
    clrf	T2CON		;1:1 pre, 1:1 post
    clrf	TMR2		;vynulovat citac
    movlw	0xFF		;(4000000/4)/256 = 3906.25 Hz
    movwf	PR2		;nastavit na max. hodnotu
    bsf		T2CON,2		;TMR2ON	;po nastaveni vseho zapnout TMR2

    ;config PWM1
    movlb	12
    clrf	PWM2DCH
    clrf	PWM2DCL
    bsf		PWM2CON,6	; PWM1OE ;povolit vystup signalu na pin
    bsf		PWM2CON,7	; PWM1EN ;spustit PWM1

    movlw	0x06
    movwf	FSR0H		
    movlw	0x15
    movwf	FSR0L		; PWM1DCH pomoci nepr. addresovani

    movlb	0		; Banka0 s PORT
	
    ;config ADC
    movlb	1		; Banka1 s ADC
    movlw	00101001B	; P2 = AN10
    movwf	ADCON0
    movlw	01110000B	; leftAlig, FRC, VDD
    movwf	ADCON1
    clrf	ADCON2		; single conv.
    bsf		ADCON0,0	; ADON ;zapnout ADC
Loop:
    
    clrw
    movlb	1		; Banka1 s ADC
    bsf		ADCON0,1	; GO ; start A/D prevodu
    btfsc	ADCON0,1	; GO ; A/D prevod skoncen?
    goto	$-1             ; pokud ne, navrat o radek vyse

    movf	ADRESH,W
    movwf	INDF0		; zapsat do PWM2DCH
    
    ;call	Delay100	; jen aby u 7seg nesvitily i nepouzite segmenty

    goto	Loop
    
    ; ======
    
    ;clrw
    ;btfsc	BT2		; test BT2 
    ;addlw	84		; -> +33%
    ;btfsc	BT1		; test BT1 
    ;addlw	171		; -> +67%

    ;movwf	INDF0		; zapsat do PWM1DCH

    goto	Loop


	
#include	"Config_IOs.inc"
		
END
