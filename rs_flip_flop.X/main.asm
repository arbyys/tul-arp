	list	p=16F1508
	#include	"p16f1508.inc"
    
	#define	buttS	PORTA,4
	#define buttR	PORTA,5
	#define ledka	PORTC,5	
	
    __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
    __CONFIG _CONFIG2, _WRT_OFF & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON

    ORG 0x00
    GOTO    Start
    
    ORG 0x04
    NOP
    RETFIE

Start:
    MOVLB   .1
    MOVLW   b'00010000'
    MOVF    OSCCON
    CALL    Config_IOs
    MOVLB   .0

Main:
    BTFSC   buttS
    BSF	    ledka
    BTFSC   buttR
    BCF	    ledka
    goto    Main
    
    #include "Config_IOs.inc"
    
END