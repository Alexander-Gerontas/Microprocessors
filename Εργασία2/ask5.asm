.dseg
.ORG 0x0100
	array: .byte 10
	
.cseg
.ORG 0x0000

	eor r16, r16 ; i = 0
	eor r17, r17 ; tmp = 0
	eor r18, r18 ; sum = 0
	eor r19, r19 ; borrow

	ldi r27, high(array) ; initialize X
	ldi r26, low(array)

start:
	rjmp main

main:
	ld r17, X+ ; tmp = array[i]	
	add r18, r17 ; sum = sum + tmp
	brcs borrow ; if carry flag is on goto borrow

cont:

	inc r16 ; i++
	cpi r16, 10 ; if i < 10...
	;cpi r16, 4 ; if i < 4
		
	brcs main ; goto main 
	rjmp start

borrow:
	inc r19 ; borrow++
	rjmp cont
	
