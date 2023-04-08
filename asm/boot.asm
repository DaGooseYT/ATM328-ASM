; ATM328-ASM boot loader for ATmega328p MCU
;
; Copyright (C) 2023 DaGoose

	.device ATmega328P
	
	; page size in bytes
	.equ	PSBYTE = 256
	.org	0x3F00

	jmp Main

    ; r0, r1, r16, r17 -> general registers
    ; r20 -> spmcrval
    ; r24 -> loop low
    ; r25 -> loop high

Main:
    ; enable PINC0 output (ready LED)
    ldi		r16, (1 << PINC0)
    out     DDRC, r16
    out     PORTC, r16
    ; disable interrupts
    in		r17, SREG
    cli
    ; program
    jmp		WaitEE
    jmp		ErasePage
    jmp		WaitSpm
    jmp		WritePageLoop
    jmp		WaitSpm
    jmp		ReadLoop
    jmp		Return
    ; re-enable interrupts
    out		SREG, r17
    ; disable SPM
    ldi		r16, 0x00
    out		SPMCSR, r16
    ; jump to application start address
    jmp		0x0000

ErasePage:
    ldi		r20, (1 << PGERS) | (1 << SELFPRGEN)
    spm
    ; enable RWW
    ldi		r20, (1 << RWWSRE) | (1 << SELFPRGEN)
    spm
    ; RAM to page buffer transfer
    ldi		r24, low(PSBYTE)

WritePageLoop:
    ld		r0, Y+
    ld		r1, Y+
    ldi		r20, (1 << SELFPRGEN)
    spm
    adiw	ZH:ZL, 2
    sbiw	r25:r24, 2
    brne	WritePageLoop
    ; page write
    subi	ZL, low(PSBYTE)
    sbci	ZH, high(PSBYTE)
    ldi		r20, (1 << PGWRT) | (1 << SELFPRGEN)
    spm
    ; enable RWW
    ldi		r20, (1 << RWWSRE) | (1 << SELFPRGEN)
    spm

ReadLoop:
    lpm		r0, Z+
    ld		r1, Y+
    ; if registers' content aren't equal, call error label.
    cpse	r0, r1
    rjmp	Error
    sbiw	r25:r24, 1
    brne	ReadLoop

WaitSpm:
    in		r16, SPMCSR
    sbrc	r16, SELFPRGEN
    rjmp	WaitSpm

WaitEE:
    sbic	EECR, EEPE
    rjmp	WaitEE
    out		SPMCSR, r20
    spm
    ret

Error:
    ; enable PINC1 output (error LED)
    ldi		r16, PINC1
    out		DDRC, r16
    out		PORTC, r16
    rjmp	Error

Return:
    ; return to RWW and confirm if safe to read.
    in		r16, SPMCSR
    sbrs	r16, RWWSB
    ret
    ; enable RWW
    ldi		r20, (1 << RWWSRE) | (1 << SELFPRGEN)
    spm
    rjmp	Return