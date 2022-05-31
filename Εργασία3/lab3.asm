.dseg
.ORG 0x0100
	arrayA: .byte 10
	arrayB: .byte 10
	arrayC: .byte 10

.cseg
	.ORG 0x0000
				
start:		
	ldi r16, 0b11101010 ; set PCn for STB and acknowledge
	out DDRC, r16

	ldi r16, 0b00000000 ; clear portC
	out PORTC, r16

	out DDRB, r16 ; PBn will be used for input
	out DDRD, r16 ; PDn will be used for input

	ldi r18, 30 ; initialize r18 for delay

	ldi r27, high(arrayA) ; initialize X
	ldi r26, low(arrayA)

	ldi r29, high(arrayB) ; initialize Y
	ldi r28, low(arrayB)

	ldi r31, high(arrayC) ; initialize Z
	ldi r30, low(arrayC)

polling:
	sbic PORTC, 0 ; if portC[0] = 1
	rcall devA    ; read input from devA

	sbic PORTC, 2 ; if portC[2] = 1
	rcall devB	  ; read input from devB

	sbic PORTC, 4 ; if portC[4] = 1
	rcall devC	  ; read input from devC

	rjmp polling  ; jmp to polling and check the devices again

devA:
	in r17, PORTB       ; r17 = portB
	st X+, r17	        ; arrayA[i] = r17
	ldi r16, 0b00000010 ; send acknowledge to portC[1]
	out PORTC, r16
	rcall delay			; delay for about 10ìsec
	ret					; return from routine

devB:
	in r17, PORTD        
	andi r17, 0b00001111 ; r17 = portD[0-3]
	st Y+, r17           ; arrayB[i] = r17		
	ldi r16, 0b00001000  ; send acknowledge to portC[3]
	out PORTC, r16       
	rcall delay	         ; delay for about 10ìsec
	ret                  ; return from routine

devC:
	in r17, PORTD
	andi r17, 0b11110000 ; r17 = portD[4-7]
	st Z+, r17           ; arrayC[i] = r17		
	ldi r16, 0b00100000  ; send acknowledge to portC[5]
	out PORTC, r16	
	rcall delay          ; delay for about 10ìsec	
	ret                  ; return from routine

delay:
	nop
	dec r18     ; r18 = r18 - 1
	breq return ; if r18 == 0 return
	rjmp delay  ; else goto delay

return:
	ldi r18, 30 ; before return set r18 = 30
	ret