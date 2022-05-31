.dseg
.ORG 0x0100
	array: .byte 10
	
.cseg
	.ORG 0x0000
				
start:
	ldi r27, high(array) ; αρχικοποίηση του δείκτη X
	ldi r26, low(array)

	ldi r16, 10 ; r16 = 10
	ldi r17, 3 ; r17 = 2
	ldi r18, 2; r18 = 2
	
	rcall fill_array ; Γεμίζουμε τον πίνακα με την χρήση της fill array

	ldi r27, high(array) ; Καθώς ο δείκτης X θα δείχνει τωρα στο τέλος του πίνακα
	ldi r26, low(array) ; τον αρχικοποιούμε ξανά για να δείχνει στο πρώτο κελί

	ldi r16, 10 ; Δίνουμε στον καταχωρητή r16 το μέγεθος του πίνακα 
	ldi r17, 8 ; Το στοιχείο του πίνακα που ψάχνουμε -> π.χ 8	
	ldi r18, 0 ; η θέση αποθηκεύεται στον καταχωρητή r18. Αν το στοιχείο δεν βρεθεί η τιμή του καταχωρητή παραμένει 0.

	rcall find_element ; Αναζήτη του στοιχείου με την find element

	rjmp start

fill_array:
	st X+, r17 ; array[i] = r17
	
	add r17, r18 ; r17 = r17 + r18
	inc r18 ; r18++
	dec r16 ; r16 = r16 - 1
	
	breq return ;if r16 == 0 return
	rjmp fill_array ; else goto fill array


find_element:

	ld r19, X+ ; r19 = array[i]

	cp r17, r19 ; σύγκριση της τιμής του r19 με το στοιχείο που ψάχνουμε
	breq get_pos ; αν r17 = r19 αποθηκεύουμε την θέση στην get_pos

	cpi r16, 0 
	breq return ; Αν έχουμε προσπελάσει όλα τα στοιχεία επιστρέφουμε απο την ρουτίνα.

	dec r16 ; r16 = r16 - 1

	rjmp find_element ; Aλλιώς συνεχίζουμε να ελέγχουμε τα υπόλοιπα στοιχεία του πίνακα

get_pos:	
	mov r18, r26 ; Αποθήκευση της θέσης του στοιχείου στον καταχωρητή r18
	
return:	
	ret