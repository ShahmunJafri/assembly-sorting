INCLUDE Irvine32.inc

;data 5/23/2023
;Assignment 5
;This assignment is an overview on procedures
; I have created 5 procedures
; the loop contains 4 of them
; the locate procedure is called 
; by the other procedures

.data

sum SDWORD ?
difference SDWORD ?
first SDWORD ?
second SDWORD ?
reset DWORD 0
xcord BYTE 20
ycord BYTE 10
;i have reset values because i dont want 
;to hard code anything
yreset BYTE 10
xreset BYTE 20
count DWORD 3
prompt1 BYTE "Enter the first number: ", 0
prompt2 BYTE "Enter the second number: ", 0
prompt3 BYTE "Press any key...", 0
sumPrompt BYTE "The sum is: ", 0
diffPrompt BYTE "The difference is: ", 0

.code
main PROC

;loop1
;structure of code
;ask user procedure
;sum procedure
;difference procedure
;wait for key procedure
;end loop

mov ecx, count ;set count of loop

;this loop is fairly simple, it 
;just calls all the procedures
;no hard coding 
L1:
	call input
	call sumProc
	call differenceProc
	call wfk
Loop L1 
	exit
main ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;locate procedure this calls gotoxy
;sets all the values
;increases ycord
;calls gotoxy
locate PROC
	mov dl, xcord
	mov dh, ycord
	call gotoxy
	inc ycord
	ret
locate ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input procedure this takes user input
;takes user input
;returns 2 SDWORD
;takes 2 strings

input PROC
	call locate ;first places input in the middle of screen
	mov edx, OFFSET prompt1 ;displays prompt
	call WriteString
	call ReadInt
	mov first, eax
	call locate
	mov edx, OFFSET prompt2 ;displays prompt
	call WriteString
	call ReadInt
	mov second, eax
	ret 
input ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sum procedure
;simply just adds two numbers 
;returns a sum
;takes 2 SDWORD 
;takes string
sumProc PROC
	call locate
	mov edx, OFFSET sumPrompt
	call WriteString
	mov eax, first
	add eax, second
	call WriteInt
	ret
sumProc ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;returns a difference
;takes 2 SDWORD 
;takes string
;difference procedure
;just subtracts 2 numbers
differenceProc PROC
	call locate
	mov edx, OFFSET diffPrompt
	call WriteString
	mov eax, first
	sub eax, second
	call WriteInt
	ret
differenceProc ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;wait for key procedure
; this resets everything
;clear the screen
;takes a string
;takes 2 BYTES
wfk PROC
	call locate
	mov edx, OFFSET prompt3
	call writeString
	mov al, yreset
	mov ycord, al
	mov al, xreset
	mov xcord, al
	call readchar
	call ClrScr
	ret
wfk ENDP
END main

