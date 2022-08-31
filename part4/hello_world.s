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
	; Set all pins on port B to output
	lda #%11111111
	sta DDRB

	; Set top 3 pins of port A to output
	lda #%11100000
	sta DDRA

	; Set 8-bit mode, 2 line display, 5x8 pixel font
	lda #%00111000
	sta PORTB

	; Toggle enable bit
	lda #0
	sta PORTA
	lda #LCD_E
	sta PORTA
	lda #0
	sta PORTA

	; Set display on, cursor on, blink off
	lda #%00001110
	sta PORTB

	; Toggle enable bit
	lda #0
	sta PORTA
	lda #LCD_E
	sta PORTA
	lda #0
	sta PORTA

	; Increment cursor pointer without shifting display
	lda #%00000110
	sta PORTB

	; Toggle enable bit
	lda #0
	sta PORTA
	lda #LCD_E
	sta PORTA
	lda #0
	sta PORTA

	lda #"H"
	sta PORTB

	; Keep register select bit set for data while toggling enable
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA




	lda #"e"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"l"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"l"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"o"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #","
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #" "
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"w"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"o"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"r"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"l"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"d"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA

	lda #"!"
	sta PORTB
	lda #LCD_RS
	sta PORTA
	lda #(LCD_RS | LCD_E)
	sta PORTA
	lda #LCD_RS
	sta PORTA


loop:
	jmp loop

	.org $fffc
	.word reset
	.word $0000
