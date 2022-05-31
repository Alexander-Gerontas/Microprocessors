.dseg
.ORG 0x0100
	
.cseg
	.ORG 0x0000
				
init_port:		
	ldi r16, 0b00001111
	out DDRB, r16 ; Τα λιγότερο σημαντικά bit της θύρας Β θα χρησιμοποιηθούν για είσοδο

	ldi r16, 0b00000000
	out PORTB, r16 ; αρχικοποίηση της θύρας Β

main:
	rcall start
	rjmp main

start:
	in r17, PORTB ; Διάβασμα της τιμής από το portB
		
	lsr r17 ; Αποκοπή τον τελευταίων 4 bit
	lsr r17
	lsr r17
	lsr r17

	ldi r16, 0b00000001 ; Αποστολή θετικού παλμού στο πιο σημαντικό bit της θύρας
	out PORTB, r16
	
	rcall delay	; Καθυστέρηση που διαρκεί όσο τα bit που διαβάστηκαν

	ldi r16, 0b00000000 ; Επαναφορά του bit στο 0
	out PORTB, r16

	ret ; Επιστροφή από την ρουτίνα
	
delay:
	ldi r16, 1

	rcall loop

	dec r17

	breq return

	rjmp delay

loop:
	nop 	

	dec r16 ; r16 = r16 - 1
	breq return ; if r16 == 0 return
	rjmp loop ; else goto loop

return:	
	ret