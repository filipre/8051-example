; Blinklicht
; 
; Taster 1: Licht einschalten
; taster 2: Licht ausschalten
; taster 3: Licht blinkt
; 
; Registerank (0)
; R2       Zaehlervariable n*65,536mys
;
;----------------------
;Initialisierung
; -----------------
;
V_BLINK EQU 2
cseg at 0h		;von vorne anfangen
jmp INIT

; -------------
; Interrupt
; -------------
org 0Bh			;feste adresse
TIME_INT0:
call TIMER_0
reti			;returm from interrupt

;----------
; Initialisierungsteil
;-------------
org 100h
INIT:
setb P3.2
mov R2,#V_BLINK
mov IE, #10010010b
mov TMOD, #00000001b
mov TCON, #00100000b

;---------------
; Programmschleife
;---------------

ABFRAGE:
jnb P1.1,Lampe_an	;jump not bit
jnb P1.2,Lampe_aus
jnb P1.3,Lampe_blinkt
ajmp ABFRAGE

Lampe_an:
clr TR0
clr P3.2
ajmp ABFRAGE

Lampe_aus:
clr TR0
setb P3.2
ajmp ABFRAGE

Lampe_blinkt:
mov TL0,#0FEh
mov TH0,#0FEh
setb TR0
ajmp ABFRAGE


;------------
; Unterprogramm Timer 0 ISR
;------------
TIMER_0:
djnz R2,SPRUNG		;decrease jump not zero
cpl P3.2		;complement/invertieren
mov R2,#V_BLINK
SPRUNG:
mov TL0,#0FEh
mov TH0,#0FFh
ret

end