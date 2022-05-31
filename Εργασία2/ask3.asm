.cseg
.ORG 0x0000

start:
		
	ldi r17, 0x80 ; initialization
	ldi r16, 4 ; i = 4

while:
	lsr r17 ; r17 = r17 / 2
	dec r16 ; i--
	cpi r16, 0 ; if i != 4...
	brne while
	jmp start