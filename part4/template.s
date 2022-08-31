	; start at 8000 (start of ROM)
	.org $8000

reset:
	lda #$ff
	sta $6002

loop:
	nop
	jmp loop

	.org $fffc
	.word reset
	.word $0000
