.dseg
.ORG 0x0100
	array: .byte 10 
	var: .byte 1

.cseg
.ORG 0x0000

	eor r16, r16 ; i = 0
	eor r18, r18 ; sum = 0
	ldi r27, high(array) ; initialize X
	ldi r26, low(array)


next:
	ld r17, X+ ; r17 = array[i]
	
	add r18, r17
	inc r16 ; i++
	cpi r16, 10 ; if i < 10...
		
	brcs next ; ...goto next