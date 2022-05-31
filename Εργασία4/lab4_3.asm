.dseg
.ORG 0x0100
	
.cseg
	.ORG 0x0000
				
start:
	
	ldi r18, 0b00000000
	
	out DDRB, r18 ; H θύρα Β θα χρησιμοποιηθεί για είσοδο
	out PORTB, r18 ; αρχικοποίηση της θύρας Β

	ldi r16, 0 ; αρχικοποίηση του r16 για την αποθηκευση των bit με τιμή 1.
		
main:	
	rcall routine ; κλήση της ρουτίνας
	rjmp main

routine:
	in r17, PORTB ; Διαβάζουμε τα δεδομένα της θύρας Β στον καταχωρητή r17

	rcall bit_cnt ; Καλούμε την ρουτίνα bit_cnt για να μετρήσουμε τα bit με τιμή 1

	ret ; Επιστροφή από την ρουτίνα

bit_cnt:

	lsr r17 ; Διαβάζουμε ένα bit από το r17 (από το τελευταίο στο πρώτο)
	brcs inc_bin ; Aν το bit έχει τιμή 1 καλούμε την inc_bin για να αυξήσουμε την τιμή του r16 

	cpi r17, 0 ; Ελέγχουμε αν το r17 έχει μηδενιστεί
	brne bit_cnt ; Αν όχι ξανακαλούμε την bit_cnt και συνεχίζουμε να διαβάζουμε τα επόμενα bit

	ret ; Αλλιώς επιστρέφουμε από την ρουτίνα
	
inc_bin:	
	inc r16 ; r16 = r16 + 1
	rjmp bit_cnt