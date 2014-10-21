org 0h
lcall Initialization
lcall clear
mov a,#'H'
lcall dat
mov a,#'I'
lcall dat
mov a,#8ah
lcall command
mov a,#'G'
lcall dat
mov a,#'o'
lcall dat
mov a,#'o'
lcall dat
mov a,#'g'
lcall dat
mov a,#'l'
lcall dat
mov a,#'e'
lcall dat
agains: sjmp agains
initialization:
mov A, #38H ; Initialize, 2-lines, 5X7 matrix.
lcall Command
mov A, #0EH ; LCD on, cursor on
lcall Command
mov A, #01H ; Clear LCD Screen
lcall Command
mov A, #06H ; Shift cursor right
lcall Command
ready:
setb P1.7 ;D7 as input
clr P2.1 ;RS=0 cmd
setb P2.0 ;RW=1 for read
again:
setb P2.2 ;H->L pulse on E
clr P2.2
jb P1.7, again
ret
dat:
mov P1, a ;move acc. dat to port
setb P2.1 ;RS=1 dat
clr P2.0 ;RW=0 for write
setb P2.2 ;H->L pulse on E
clr P2.2
lcall ready
ret
command:
mov P1, A ;move acc. dat to port
clr P2.1 ;RS=0 for cmd
clr P2.0 ;RW=0 for write
setb P2.2 ;H->L pulse on E
clr P2.2
lcall ready
ret
clear:
setb P2.2 ;enable EN
clr P2.1 ;RS=0 for cmd.
mov a,#01h
clr P2.2 ;disable EN
lcall ready
ret
lcall initialization
lcall clear
mov A,#'H'
acall dat
mov A,#'I'
lcall dat
end