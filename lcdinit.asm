ORG	0000H
;_-------------------------
RS	bit	P3.0
RW	bit	P3.1
E	bit	P3.2
D	equ	P2
;--------------------------
	clr	E
	clr	RW
	clr	RS
	clr	D
	jmp	init
	;jmp	main
;--------------------------
string:
db 23,24,25,26,27,28,29,30,31,32
;--------------------------
lcd_enable:
	nop
	setb	E
rept 10
	nop
endm
	clr	E
;	call	sleep_50us
	ret

sleep_50us:
	mov	R0, #018h
	nop
	djnz	R0, $
	ret
sleep_5ms:
	mov	R1, #011h
	mov	R0, #091h
	nop
	djnz	R0, $
	djnz	R1, $-5
	nop
	ret

LCD_string:
         clr   a                 ;clear Accumulator for any previous data
         movc  a,@a+dptr         ;load the first character in accumulator
         jz    exit              ;go to exit if zero
         acall lcd_data      ;send first char
         inc   dptr              ;increment data pointer
         sjmp  lcd_string    ;jump back to send the next character
exit:
         ret                     ;End of routine

lcd_data:
	clr	RW
	setb	RS
	call	lcd_enable
	call	sleep_50us
	ret

lcd_cmd:
	clr	RW
	clr	RS
	call	lcd_enable
	call	sleep_50us
	ret

lcd_clear:
	mov	D, #00000001b	;Bildschirm leeren
	call	lcd_cmd
	ret
	
lcd_reset_cursor:
	mov	D, #00000010b	;Cursor Reseten
	call	lcd_cmd
	ret

shift_left:
	mov 	D, #01Ch	;right shift
	call	lcd_cmd
	ret

shift_right:
	mov	D, #018h	;left shift
	call	lcd_cmd
	ret

init:
	call    sleep_5ms
	mov	D, #00000011b   ;Soft Reset
	call	lcd_enable
	call	sleep_5ms
	call	lcd_enable
	call	sleep_5ms
	call	lcd_enable
	call	sleep_5ms

init2:
	;call sleep_5ms
	mov	D, #00111000b	;Modus einstellen 8-bit / 2 Zeilen / 5x7 Font
	call	lcd_cmd

	mov	D, #00000110b	;Modus einstellen Increment / Fester Inhalt
	call	lcd_cmd

	mov	D, #00001100b	;Modus einstellen Display An / Cursor Aus / Cursor Blinkt Nicht
	call	lcd_cmd


main:

	call lcd_clear
	call lcd_reset_cursor

	mov   dptr,#string  ;my_string is the label where the string is stored
 	call lcd_string    ;Send string
	jmp hin_init

	
		
;	mov	D, #10000000b   ;Set Address of first Cell
;	call	lcd_cmd
;	mov	D, #65		;Print A
;	call	lcd_data
	mov	D, #11000000b   ;Set Address of first Cell
	call	lcd_cmd
	mov	D, #72
	call	lcd_data
	mov	D, #65
	call	lcd_data
	mov	D, #76
	call	lcd_data
	mov	D, #76
	call	lcd_data
	mov	D, #79
	call	lcd_data
	mov	D, #32
	call	lcd_data
	mov	D, #87
	call	lcd_data
	mov	D, #69
	call	lcd_data
	mov	D, #76
	call	lcd_data
	mov	D, #0ACh
	call	lcd_data
	mov	D, #33
	call	lcd_data

hin_init:
	mov	R2, #50
hin:
	dec	R2
	call 	shift_right
	call	sleep_50us
	djnz	R2, hin
	jmp	her_init
her_init:
	mov	R2, #50
her:
	dec 	R2
	call	shift_left
	call 	sleep_50us
	djnz	R2, her
	jmp 	hin_init

while:
	nop
;	jmp	while

	end