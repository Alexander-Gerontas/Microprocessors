; Replace with your application code
.dseg
.ORG 0x0100
	var1: .byte 1
	var2: .byte 1		
	result: .byte 1

.cseg
.ORG 0x0000

start:
		
	ldi r17, 0x80 ; initialization
	ldi r16, 0 ; i = 0
	
	
next:
	lsr r17 ; r17 = r17 / 2
	inc r16 ; i++
	cpi r16, 4 ; if i < 4...
	;brne next ; ...goto next	brcs next ; ...goto nextexit:	rjmp start