; Author: Katelyn Nguyen - CS 271
; Program: Assignment #2
; Date: 10/18/2020
; Description: This programs takes negative integers from user input and prints their sum and rounded average.
; Extra Credit Completed: Line numbers for user input

INCLUDE Irvine32.inc

; constants
LOWER	=	-100
UPPER	=	-1

.data
welcomeMessage		BYTE	"Welcome to the Integer Accumulator by Katelyn Nguyen", 0
promptName			BYTE	"What is your name? ", 0
greet				BYTE	"Hello, ", 0
printRange			BYTE	"Please enter numbers in [-100, -1].", 0
printRule			BYTE	"Enter a non-negative number when you are finished to see results.", 0
promptNum			BYTE	"Enter number: ", 0
noNum				BYTE	"NO NUMBERS ENTERED", 0
youEntered			BYTE	"You entered ", 0
validNum			BYTE	" valid numbers", 0
printSum			BYTE	"The sum of your valid numbers is ", 0
printAverage		BYTE	"The rounded average is ", 0
goodbye				BYTE	"Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ", 0
semicolon			BYTE	":  ", 0

username			BYTE  64 DUP(0)
sum					DWORD 0
average				DWORD 0
counter				DWORD 0
lineNum				DWORD 0



.code
main PROC

; Call procedure to display instructions
	call Instructions

; Call procedure to get user input and calculate sum
	call SumOf

; If there were zero valid inputs, call procedure to display message
	cmp counter, 0
	jg continue
	call ZeroInput
	jmp ending

continue:

; Call procedure to get average
	call AverageOf

; Call procedure to display results
	call PrintResults
	
ending:

; Call procedure to display closing message
	call ClosingMessage

exit  ; exit to operating system
main ENDP



; This procedure displays instructions and prompts user for name
Instructions PROC
; Display title and author.
	mov		edx, OFFSET welcomeMessage
	call writeString
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

; Print range and rules
	mov		edx, OFFSET printRange
	call writeString
	call Crlf
	mov		edx, OFFSET printRule
	call writeString
	call Crlf
ret
Instructions ENDP


; This procedure gets numbers from user input and calculates the sum
SumOf PROC
	getNum:
	; Extra Credit: Print line numbers for user input
		add lineNum, 1
		mov		eax, lineNum
		call writeDec
		mov		edx, OFFSET semicolon
		call writeString
	
	; Prompt user to enter number
		mov		edx, OFFSET promptNum
		call writeString
		call readInt

	; If user enters number lower than -100, ignore input and start loop again 
		cmp eax, LOWER
		jl getNum

	; If user enters number bigger than -1, end loop 
		cmp eax, UPPER
		jg End1

	; Accumulate user input and increase counter
		add	sum, eax
		inc counter
		jmp getNum

	End1:
ret
SumOf ENDP


; This procedure displays a message if there was no valid input
ZeroInput PROC
		mov		edx, OFFSET noNum
		call writeString
		call Crlf
ret
ZeroInput ENDP


; This procedure calculates the average of the numbers
AverageOf PROC
	; Divide the accumulated sum by the number of valid integers
		mov		edx, 0 
		mov		eax, sum
		cdq
		mov		ebx, counter
		idiv ebx
		mov		average, eax

	; Round -0.5 down
		mov		eax, edx
		mov		ebx, -2
		imul ebx				; Multiply remainder by 2
		cmp eax, counter	
		jge decrease			; If it's >= than the divisor, round down
		jl end1			
		decrease:
			dec average
		end1:

	ret
AverageOf ENDP 


; This procedure prints the results: total valid ints, sum, average
PrintResults PROC
	; Displays number of valid integer
		mov		edx, OFFSET youEntered
		call writeString
		mov		eax, counter
		call writeDec
		mov		edx, OFFSET validNum
		call writeString
		call Crlf

	; Displays sum
		mov		edx, OFFSET printSum
		call writeString
		mov		eax, sum
		call writeInt
		call Crlf

	; Displays rounded average
		mov		edx, OFFSET printAverage
		call writeString
		mov		eax, average
		call writeInt
ret
PrintResults ENDP


; This procedure displays the closing message
ClosingMessage PROC
		call Crlf
		mov		edx, OFFSET goodbye
		call writeString
		mov		edx, OFFSET username
		call writeString
		call Crlf
ret
ClosingMessage ENDP


END main

