; demo file that lights LED at PINB0	
	
    .device ATmega328P

    .cseg
    .org 	0x0000

    ldi		r16, (1 << PINB0)
    out     DDRB, r16
    out     PORTB, r16

Loop:
    rjmp    Loop
