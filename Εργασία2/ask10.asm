.dseg
.ORG 0x0100
	A: .byte 1
	B: .byte 1
	C: .byte 1

.cseg
.ORG 0x0000

start:
	ldi r16, low(RAMEND) ; set up the stack
	out SPL, r16
	ldi r16, high(RAMEND)
	out SPH, r16
	lds r16, A ; Input arguments
	lds r17, B	
	rcall calc
	;call calc
	sts C, r18 ; Output argument
rjmp start

calc:
	add r16, r16 ; 2*A		mov r18, r16		sub r18, r17 ; 2*A - B
	add r18, r18 ; 4*A - 2*B	ret