; Author: Katelyn Nguyen - CS 271
; Program: Assignment #2
; Date: 10/10/2020
; Description: Fibonacci Numbers. Program prompts user to enter how many Fibonacci numbers to display.

INCLUDE Irvine32.inc

; constants
LOWER = 1
UPPER =	46	

.data
programTitle	BYTE	"Fibonacci Numbers ", 0
programmedBy	BYTE	"Programmed by ", 0
author			BYTE	"Katelyn Nguyen ", 0
promptName		BYTE	"What's your name? ", 0
greet			BYTE	"Hello, ", 0
instructions	BYTE	"Enter the number of Fibonacci terms to be displayed... It should be an integer in the range [1, 46]", 0
promptNumber	BYTE	"How many Fibonacci terms do you want? ", 0
outOfRange		BYTE	"Out of range.  Enter a number in [1, 46] ", 0
certify			BYTE	"Results certified by ", 0
goodbye			BYTE	"Goodbye, ", 0
space			BYTE	"    ", 0

username		BYTE  	64 DUP(0)
numOfTerms		DWORD ?
num1			DWORD 1
num2			DWORD 0
temp			DWORD ?
lineCount		DWORD 0
row				DWORD 0




.code
main PROC

; Display title and author.
	mov		edx, OFFSET programTitle
	call writeString
	mov		edx, OFFSET programmedBy
	call writeString
	mov		edx, OFFSET author
	call writeString
	call Crlf
	call Crlf

; Ask user for name.
	mov		edx, OFFSET promptName
	call writeString
	mov		edx, OFFSET username
	mov		ecx, SIZEOF username
	call readString

; Greet user.
	mov		edx, OFFSET greet
	call writeString
	mov		edx, OFFSET username
	call writeString
	call Crlf
	call Crlf

; Prompt user for amount of Fibonacci numbers
	mov		edx, OFFSET instructions
	call writeString
	call Crlf
	mov		edx, OFFSET promptNumber
	call writeString
	jmp GetNum			; first time prompting user, so skip over error message

errorMessage:
	mov		edx, OFFSET outOfRange
	call writeString

GetNum:
	call readDec

; Validate user input [1-46]
	cmp eax, LOWER
	jl errorMessage
	cmp eax, UPPER
	jg errorMessage

; Once input is validated, store in numOfTerms
	mov		numOfTerms, eax		

; Print fibonacci sequence
	mov		ax, 0
	mov		ecx, numOfTerms 	; set loop count
fibonacci:
	mov		eax, lineCount
	cmp eax, 4					; start on a new line every 4 numbers
	jne continue
	
newline:
	call Crlf
	mov		lineCount, 0		; reset count to zero
	inc	row						; keep count of rows for lining up columns

continue:
	mov		edx, 0
	mov		eax, num1
	call writeDec				; print fibonacci number
	mov		temp, eax
	add	eax, num2
	mov		num1, eax
	mov		eax, temp
	mov		num2, eax
	
; Align the columns
	mov     al, 9               
    call writeChar   
	mov		eax, row
	cmp row, 9
	jge continue2				; skip extra tab - Rows 9-12 need one less tab to line up
	mov     al, 9
	call writeChar

continue2:
	inc lineCount				; keep track of every 4 numbers
	inc ax
	loop fibonacci

; Print goodbye statements
	call Crlf
	call Crlf
	mov		edx, OFFSET certify
	call writeString
	mov		edx, OFFSET author
	call writeString
	call Crlf
	mov		edx, OFFSET goodbye
	call writeString
	mov		edx, OFFSET username
	call writeString
	call Crlf




exit  ; exit to operating system
main ENDP
; (insert additional procedures here)
END main