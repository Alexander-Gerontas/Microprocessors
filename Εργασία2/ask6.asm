.dseg
.ORG 0x0100
		
.cseg
.ORG 0x0000
		
start:
	ldi r16, 0b00100000
	out DDRB, r16
	nop
	nop

loop:
	ldi r16, 0b11111111
	out PORTB, r16
	nop
	nop
	ldi r16, 0b11011111
	out PORTB, r16
	nop
	nop
	rjmp loop