; IO ports
PORTB = $6000
PORTA = $6001

; Data direction registers
DDRB = $6002
DDRA = $6003

; LCD control bits
LCD_E = %10000000
LCD_RW = %01000000
LCD_RS = %00100000

	; start at 8000 (start of ROM)
	.org $8000

reset:
	; Set stack pointer from x register
	ldx #$ff
	txs

	; Set all pins on port B to output
	lda #%11111111
	sta DDRB

	; Set top 3 pins of port A to output
	lda #%11100000
	sta DDRA

	; Set 8-bit mode, 2 line display, 5x8 pixel font
	lda #%00111000
	jsr send_lcd_instruction

	; Set display on, cursor on, blink off
	lda #%00001110
	jsr send_lcd_instruction

	; Increment cursor pointer without shifting display
	lda #%00000110
	jsr send_lcd_instruction

	; Clear screen
	lda #%00000001
	jsr send_lcd_instruction

	lda #"H"
	jsr print_char
	lda #"e"
	jsr print_char
	lda #"l"
	jsr print_char
	lda #"l"
	jsr print_char
	lda #"o"
	jsr print_char
	lda #","
	jsr print_char
	lda #" "
	jsr print_char
	lda #"w"
	jsr print_char
	lda #"o"
	jsr print_char
	lda #"r"
	jsr print_char
	lda #"l"
	jsr print_char
	lda #"d"
	jsr print_char
	lda #"!"
	jsr print_char



loop:
	jmp loop

send_lcd_instruction:
	; Send LCD instruction held in register a
	sta PORTB

	; Toggle enable bit
	lda #0
	sta PORTA
	lda #LCD_E
	sta PORTA
	lda #0
	sta PORTA
	rts

print_char:
	; Send character from register a
	sta PORTB

	; Keep register select bit set for data while toggling enable
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA
	rts


	.org $fffc
	.word reset
	.word $0000
