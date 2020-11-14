; Author: Katelyn Nguyen - CS 271
; Program: Assignment #4
; Date: 10/25/2020
; Description: This program prints out the amount of composite numbers enter by the user.
; Extra Credit Completed: Align columns

INCLUDE Irvine32.inc

; constants
LOWER	=	1
UPPER	=	400

.data
progTitle			BYTE	"Composite Numbers Programmed by ", 0
progAuthor			BYTE	"Katelyn Nguyen", 0
instructions		BYTE	"Enter the number of composite numbers you would like to see.", 0
instructions2		BYTE	"I will accept orders for up to 400 composites.", 0
promptUser			BYTE	"Enter the number of composites to display [1,400]: ", 0
errorMessage		BYTE	"Out of range.  Try again.", 0
resultsCertifiedBy	BYTE	"Results certified by ",0
goodbye				BYTE	", goodbye.", 0
singleSpace			BYTE	"      ", 0
doubleSpace			BYTE	"     ", 0
tripleSpace			BYTE	"    ", 0


num					DWORD 0
composite			DWORD 4
loopCount			DWORD ?
lineCount			DWORD 0
oddNum				DWORD ?





.code
main PROC

; Call procedure to display introduction
	call Introduction

; Call procedure to get user data
	call getUserData

; Call procedure to get composite numbers
	call compositeNum

; Call procedure to print goodbye message
	call farewell

exit  ; exit to operating system
main ENDP


; ---------------------------------------------------
; Displays program title and author
; Modifies edx register to display strings
; ---------------------------------------------------

Introduction PROC
	; Display title and author.
		mov		edx, OFFSET progTitle
		call writeString
		mov		edx, OFFSET progAuthor
		call writeString
		call Crlf
		call Crlf
	ret
Introduction ENDP


; ---------------------------------------------------
; Gets user input for amount of composite numbers
; Pre-Conditions: Introduction is displayed 
; Post-Conditions: Instructions are shown, user enters a number, checkInput is called
; ---------------------------------------------------
getUserData PROC
	; Display instruction
		mov		edx, OFFSET instructions
		call writeString
		call Crlf
		mov		edx, OFFSET instructions2
		call writeString
		call Crlf
		call Crlf

	; Prompt user for input
	input:
		mov		edx, OFFSET promptUser		
		call writeString 
		call readInt
		call checkInput						; Calls checkInput to validate input
	ret
getUserData ENDP


; ---------------------------------------------------
; Checks user input to see if it's within 1 - 400
; Pre-Conditions: User input received
; Post-Conditions: Prompt user error message until valid number is entered, store valid number in num
; ---------------------------------------------------
checkInput PROC
	jmp check

	input:
		mov		edx, OFFSET promptUser
		call writeString 
		call readInt

	check:									
		cmp eax, LOWER
		jl error							; if number is invalid, jump to error message
		cmp eax, UPPER
		jg error
		jmp continue						; if number is valid, skip over error message and store in num

	error:
		mov		edx, OFFSET errorMessage
		call writeString
		call Crlf
		jmp input							; jump to reprompt user for input

	continue:
		mov		num, eax
		call Crlf
	ret
checkInput ENDP


; ---------------------------------------------------
; Tests for num amount of composite numbers
; Pre-Conditions: User input received and validated
; Post-Conditions: verify if numbers are composite and calls printComposite to print numbers
; ---------------------------------------------------
compositeNum PROC
	mov		ecx, num
	Loop1:
		mov		loopCount, ecx				; Store loop count because there is nested loop

; Numbers >= 4 and divisible by 2 are composite numbers
		mov		eax, composite
		mov		ebx, 2
		cdq
		div ebx
		cmp edx, 0
		je isComposite						; Jump to code for valid composite numbers


; Loop to check if number can be divided by odd divisors
		mov		oddNum, 3
		mov		ecx, 9
	Loop2:
		mov		eax, composite
		mov		ebx, oddNum
		cmp composite, ebx
		je skip								; if number is equal to divisor, it's not composite
		cdq
		div ebx
		cmp edx, 0							; If there is no remainder, then it's composite
		je isComposite
	skip:
		add	oddNum, 2						; If there is remainder, increment divisor by 2 and repeat
	loop Loop2


; Prevents loop count from being decremented if it's not a composite number
	notComposite:
		inc loopCount						 
		jmp ending

; Calls procedure to print composite number
	isComposite:
		call printComposite

ending:
	inc composite							; increment number in loop to test if it's composite
	mov		ecx, loopCount					; restore outer loop count
	loop Loop1

	ret
compositeNum ENDP


; ---------------------------------------------------
; Prints num amount of composite numbers
; Pre-Conditions: Composite number is verified
; Post-Conditions: Prints composite numbers, eight numbers per line, aligned columns
; ---------------------------------------------------
printComposite PROC

; Aligns columns by printing spaces based on number of digits
	mov		eax, composite
	call writeDec
	cmp composite, 9
	jle singleDigit
	cmp composite, 99
	jle doubleDigit
	cmp composite, 999
	jle tripleDigit

	singleDigit:
		mov		edx, OFFSET singleSpace
		call writeString
		jmp next
	doubleDigit:
		mov		edx, OFFSET doubleSpace
		call writeString
		jmp next
	tripleDigit:
		mov		edx, OFFSET tripleSpace
		call writeString

; If it's the 8th number of the row jump to nextLine
	next:
		inc lineCount
		cmp lineCount, 8
		je nextLine
		jmp ending

; Start a new row and reset the count
	nextLine:
		call Crlf
		mov		lineCount, 0

	ending:
	ret
printComposite ENDP


; ---------------------------------------------------
; Prints goodbye message
; Pre-Conditions: Program is finished displaying num amount of composite numbers
; Post-Conditions: Goodbye message is printed, program ends
; ---------------------------------------------------
farewell PROC
	call Crlf
	call Crlf
	mov		edx, OFFSET resultsCertifiedBy
	call writeString
	mov		edx, OFFSET progAUthor
	call writeString
	mov		edx, OFFSET goodbye
	call writeString

	ret
farewell ENDP


END main








