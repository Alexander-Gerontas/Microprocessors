.dseg
.ORG 0x0100
	array: .byte 10
	
.cseg
.ORG 0x0000
	
	ldi r16, low(RAMEND) ; set up the stack
	out SPL, r16
	ldi r16, high(RAMEND)
	out SPH, r16

	eor r16, r16 ; i = 0
	eor r17, r17 ; tmp = 0
	eor r18, r18 ; sum = 0
	eor r19, r19 ; borrow

	ldi r27, high(array) ; initialize X
	ldi r26, low(array)
	
start:			
	ld r17, X+ ; tmp = array[i]	
	rcall calc ; goto calc
	inc r16 ; i++
	cpi r16, 11 ; if i < 10...

calc:	
	add r18, r17 ; sum = sum + tmp
	brcc return ; if carry flag is off return
	
	call borrow
	ret

return:
	ret
		
borrow:
	inc r19 ; borrow++
	ret
	