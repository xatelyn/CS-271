; Author: Katelyn Nguyen
; CS 271              Date: 10/4/2020
; Description: Elementary Arithmetic. Takes two numbers from user input and
;			   calculates sum, difference, product, quotient, and remainder.

	INCLUDE Irvine32.inc
; (insert constant definitions here)

.data
programTitle	BYTE	"Elementary Arithmetic by Katelyn Nguyen ", 0
intro			BYTE	"Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.", 0
prompt_1		BYTE	"First number: ", 0
prompt_2		BYTE	"Second number: ", 0
num_1			DWORD ?	
num_2			DWORD ?
printSum		BYTE	" + ", 0
printDifference	BYTE	" - ", 0
printProduct	BYTE	" * ", 0
printQuotient	BYTE	" / ", 0
printRemainder	BYTE	" remainder ", 0
printEqual		BYTE	" = ", 0
sum				DWORD ?
difference		DWORD ?
product			DWORD ?
quotient		DWORD ?
remainder		DWORD ?
goodbye			BYTE	"Impressed?  Bye!", 0


.code
main PROC
	
; Display title and author.
	mov		edx, OFFSET programTitle
	call writeString
	call Crlf
	call Crlf

; Display program instructions for the user.
	mov		edx, OFFSET intro
	call writeString
	call Crlf
	call Crlf

; Ask user to enter two numbers.
	mov		edx, OFFSET prompt_1
	call writeString
	call ReadInt
	mov		num_1, eax					; User input from the eax register gets stored in num_1

	mov		edx, OFFSET prompt_2
	call writeString
	call ReadInt
	mov		num_2, eax					; Second user input from the eax register gets stored in num_2
	call Crlf

; Addition of two numbers
	mov		eax, num_1					; move first number to eax register 
	mov		sum, eax					; move first number from eax register to sum
	mov		eax, num_2					; move second number to eax register
	add	 sum, eax						; add second number to sum


; Subtraction of two numbers
	mov		eax, num_1					; move first number to eax register
	mov		difference, eax				; move first number from eax register to sum
	mov		eax, num_2					; move second number to eax register
	sub	difference, eax				; subtract second number from difference
	

; Multiplication of two numbers
	mov		eax, num_1					; move first number to eax register
	mov		ebx, num_2					; move second number to ebx register
	imul ebx							; multiply number in eax by the number in ebx
	mov		product, eax				; move result from eax and store in product


; Division of two numbers
	mov		eax, num_1					; move first number to eax register
	mov		ebx, num_2					; move second number to ebx register
	div	ebx								; divide number in eax by the number in ebx		
	mov		quotient, eax				; move result from eax and store in quotient
	

; Remainder
	mov		remainder, edx				; remainder of division gets stored in edx so move it to remainder
	
; Print addition results
	mov		eax, num_1
	call writeDec
	mov		edx, OFFSET printSum
	call writeString
	mov		eax, num_2
	call writeDec
	mov		edx, OFFSET printEqual
	call writeString
	mov		eax, sum
	call writeDec
	call Crlf


; Print subtraction results
	mov		eax, num_1
	call writeDec
	mov		edx, OFFSET printDifference
	call writeString
	mov		eax, num_2
	call writeDec
	mov		edx, OFFSET printEqual
	call writeString
	mov		eax, difference
	call writeDec
	call Crlf

; Print multiplication results
	mov		eax, num_1
	call writeDec
	mov		edx, OFFSET printProduct
	call writeString
	mov		eax, num_2
	call writeDec
	mov		edx, OFFSET printEqual
	call writeString
	mov		eax, product
	call writeDec
	call Crlf


; Print division results
	mov		eax, num_1
	call writeDec
	mov		edx, OFFSET printQuotient
	call writeString
	mov		eax, num_2
	call writeDec
	mov		edx, OFFSET printEqual
	call writeString
	mov		eax, quotient
	call writeDec

; Print remainder
	mov		edx, OFFSET printRemainder
	call writeString
	mov		eax, remainder
	call writeDec
	call Crlf
	call Crlf

; Display goodbye to user
	mov		edx, OFFSET goodbye
	call writeString



exit  ; exit to operating system
main ENDP
; (insert additional procedures here)
END main