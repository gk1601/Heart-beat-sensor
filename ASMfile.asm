
_mask:

;PulseMeter.c,18 :: 		unsigned short mask(unsigned short num) {
;PulseMeter.c,19 :: 		switch (num) {
	GOTO       L_mask0
;PulseMeter.c,20 :: 		case 0 : return 0xC0;
L_mask2:
	MOVLW      192
	MOVWF      R0+0
	RETURN
;PulseMeter.c,21 :: 		case 1 : return 0xF9;
L_mask3:
	MOVLW      249
	MOVWF      R0+0
	RETURN
;PulseMeter.c,22 :: 		case 2 : return 0xA4;
L_mask4:
	MOVLW      164
	MOVWF      R0+0
	RETURN
;PulseMeter.c,23 :: 		case 3 : return 0xB0;
L_mask5:
	MOVLW      176
	MOVWF      R0+0
	RETURN
;PulseMeter.c,24 :: 		case 4 : return 0x99;
L_mask6:
	MOVLW      153
	MOVWF      R0+0
	RETURN
;PulseMeter.c,25 :: 		case 5 : return 0x92;
L_mask7:
	MOVLW      146
	MOVWF      R0+0
	RETURN
;PulseMeter.c,26 :: 		case 6 : return 0x82;
L_mask8:
	MOVLW      130
	MOVWF      R0+0
	RETURN
;PulseMeter.c,27 :: 		case 7 : return 0xF8;
L_mask9:
	MOVLW      248
	MOVWF      R0+0
	RETURN
;PulseMeter.c,28 :: 		case 8 : return 0x80;
L_mask10:
	MOVLW      128
	MOVWF      R0+0
	RETURN
;PulseMeter.c,29 :: 		case 9 : return 0x90;
L_mask11:
	MOVLW      144
	MOVWF      R0+0
	RETURN
;PulseMeter.c,30 :: 		} //case end
L_mask0:
	MOVF       FARG_mask_num+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_mask2
	MOVF       FARG_mask_num+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_mask3
	MOVF       FARG_mask_num+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_mask4
	MOVF       FARG_mask_num+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_mask5
	MOVF       FARG_mask_num+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_mask6
	MOVF       FARG_mask_num+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_mask7
	MOVF       FARG_mask_num+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_mask8
	MOVF       FARG_mask_num+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_mask9
	MOVF       FARG_mask_num+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_mask10
	MOVF       FARG_mask_num+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_mask11
;PulseMeter.c,31 :: 		}
	RETURN
; end of _mask

_delay_debounce:

;PulseMeter.c,33 :: 		void delay_debounce(){
;PulseMeter.c,34 :: 		Delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_delay_debounce12:
	DECFSZ     R13+0, 1
	GOTO       L_delay_debounce12
	DECFSZ     R12+0, 1
	GOTO       L_delay_debounce12
	DECFSZ     R11+0, 1
	GOTO       L_delay_debounce12
	NOP
	NOP
;PulseMeter.c,35 :: 		}
	RETURN
; end of _delay_debounce

_delay_refresh:

;PulseMeter.c,37 :: 		void delay_refresh(){
;PulseMeter.c,38 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_delay_refresh13:
	DECFSZ     R13+0, 1
	GOTO       L_delay_refresh13
	DECFSZ     R12+0, 1
	GOTO       L_delay_refresh13
	NOP
	NOP
;PulseMeter.c,39 :: 		}
	RETURN
; end of _delay_refresh

_countpulse:

;PulseMeter.c,41 :: 		void countpulse(){
;PulseMeter.c,42 :: 		IR_Tx = 1;
	BSF        RA3_bit+0, 3
;PulseMeter.c,43 :: 		delay_debounce();
	CALL       _delay_debounce+0
;PulseMeter.c,44 :: 		delay_debounce();
	CALL       _delay_debounce+0
;PulseMeter.c,45 :: 		TMR0=0;
	CLRF       TMR0+0
;PulseMeter.c,46 :: 		Delay_ms(15000);  // Delay 1 Sec
	MOVLW      153
	MOVWF      R11+0
	MOVLW      49
	MOVWF      R12+0
	MOVLW      162
	MOVWF      R13+0
L_countpulse14:
	DECFSZ     R13+0, 1
	GOTO       L_countpulse14
	DECFSZ     R12+0, 1
	GOTO       L_countpulse14
	DECFSZ     R11+0, 1
	GOTO       L_countpulse14
	NOP
;PulseMeter.c,47 :: 		IR_Tx = 0;
	BCF        RA3_bit+0, 3
;PulseMeter.c,48 :: 		pulsecount = TMR0;
	MOVF       TMR0+0, 0
	MOVWF      _pulsecount+0
;PulseMeter.c,49 :: 		pulserate = pulsecount*4;
	MOVF       _pulsecount+0, 0
	MOVWF      _pulserate+0
	RLF        _pulserate+0, 1
	BCF        _pulserate+0, 0
	RLF        _pulserate+0, 1
	BCF        _pulserate+0, 0
;PulseMeter.c,50 :: 		}
	RETURN
; end of _countpulse

_display:

;PulseMeter.c,52 :: 		void display(){
;PulseMeter.c,53 :: 		DD0 = pulserate%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _pulserate+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _DD0+0
;PulseMeter.c,54 :: 		DD0 = mask(DD0);
	MOVF       R0+0, 0
	MOVWF      FARG_mask_num+0
	CALL       _mask+0
	MOVF       R0+0, 0
	MOVWF      _DD0+0
;PulseMeter.c,55 :: 		DD1 = (pulserate/10)%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _pulserate+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _DD1+0
;PulseMeter.c,56 :: 		DD1 = mask(DD1);
	MOVF       R0+0, 0
	MOVWF      FARG_mask_num+0
	CALL       _mask+0
	MOVF       R0+0, 0
	MOVWF      _DD1+0
;PulseMeter.c,57 :: 		DD2 = pulserate/100;
	MOVLW      100
	MOVWF      R4+0
	MOVF       _pulserate+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _DD2+0
;PulseMeter.c,58 :: 		DD2 = mask(DD2);
	MOVF       R0+0, 0
	MOVWF      FARG_mask_num+0
	CALL       _mask+0
	MOVF       R0+0, 0
	MOVWF      _DD2+0
;PulseMeter.c,59 :: 		for (i = 0; i<=180*j; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_display15:
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVLW      180
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       _i+1, 0
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__display22
	MOVF       _i+0, 0
	SUBWF      R0+0, 0
L__display22:
	BTFSS      STATUS+0, 0
	GOTO       L_display16
;PulseMeter.c,60 :: 		DD0_Set = 0;
	BCF        RA2_bit+0, 2
;PulseMeter.c,61 :: 		DD1_Set = 1;
	BSF        RA1_bit+0, 1
;PulseMeter.c,62 :: 		DD2_Set = 1;
	BSF        RA0_bit+0, 0
;PulseMeter.c,63 :: 		PORTB = DD0;
	MOVF       _DD0+0, 0
	MOVWF      PORTB+0
;PulseMeter.c,64 :: 		delay_refresh();
	CALL       _delay_refresh+0
;PulseMeter.c,65 :: 		DD0_Set = 1;
	BSF        RA2_bit+0, 2
;PulseMeter.c,66 :: 		DD1_Set = 0;
	BCF        RA1_bit+0, 1
;PulseMeter.c,67 :: 		DD2_Set = 1;
	BSF        RA0_bit+0, 0
;PulseMeter.c,68 :: 		PORTB = DD1;
	MOVF       _DD1+0, 0
	MOVWF      PORTB+0
;PulseMeter.c,69 :: 		delay_refresh();
	CALL       _delay_refresh+0
;PulseMeter.c,70 :: 		DD0_Set = 1;
	BSF        RA2_bit+0, 2
;PulseMeter.c,71 :: 		DD1_Set = 1;
	BSF        RA1_bit+0, 1
;PulseMeter.c,72 :: 		DD2_Set = 0;
	BCF        RA0_bit+0, 0
;PulseMeter.c,73 :: 		PORTB = DD2;
	MOVF       _DD2+0, 0
	MOVWF      PORTB+0
;PulseMeter.c,74 :: 		delay_refresh();
	CALL       _delay_refresh+0
;PulseMeter.c,59 :: 		for (i = 0; i<=180*j; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;PulseMeter.c,75 :: 		}
	GOTO       L_display15
L_display16:
;PulseMeter.c,76 :: 		DD2_Set = 1;
	BSF        RA0_bit+0, 0
;PulseMeter.c,79 :: 		}
	RETURN
; end of _display

_main:

;PulseMeter.c,83 :: 		void main() {
;PulseMeter.c,84 :: 		CMCON = 0x07;    // Disable Comparators
	MOVLW      7
	MOVWF      CMCON+0
;PulseMeter.c,85 :: 		TRISA = 0b00110000; // RA4/T0CKI input, RA5 is I/P only
	MOVLW      48
	MOVWF      TRISA+0
;PulseMeter.c,86 :: 		TRISB = 0b10000000; // RB7 input, rest output
	MOVLW      128
	MOVWF      TRISB+0
;PulseMeter.c,87 :: 		OPTION_REG = 0b00101000; // Prescaler (1:1), TOCS =1 for counter mode
	MOVLW      40
	MOVWF      OPTION_REG+0
;PulseMeter.c,88 :: 		pulserate = 0;
	CLRF       _pulserate+0
;PulseMeter.c,89 :: 		j = 1;
	MOVLW      1
	MOVWF      _j+0
;PulseMeter.c,90 :: 		display();
	CALL       _display+0
;PulseMeter.c,91 :: 		do {
L_main18:
;PulseMeter.c,92 :: 		if(!start){
	BTFSC      RB7_bit+0, 7
	GOTO       L_main21
;PulseMeter.c,93 :: 		delay_debounce();
	CALL       _delay_debounce+0
;PulseMeter.c,94 :: 		countpulse();
	CALL       _countpulse+0
;PulseMeter.c,95 :: 		j= 3;
	MOVLW      3
	MOVWF      _j+0
;PulseMeter.c,96 :: 		display();
	CALL       _display+0
;PulseMeter.c,97 :: 		}
L_main21:
;PulseMeter.c,100 :: 		} while(1);  // Infinite loop
	GOTO       L_main18
;PulseMeter.c,101 :: 		}
	GOTO       $+0
; end of _main
