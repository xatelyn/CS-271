Include Irvine32.inc
Include algorithm.inc
.data

.code


;****************************************************************
; Title: Introduction
; Description: Print out introduction
; Parameters: progTitle (str), progDescription (str)
; Returns: Printed intro and instructions
; Registers changed: edx
;****************************************************************
Introduction PROC
	push ebp
	mov		ebp, esp

	; Display title and author.
		mov		edx, [ebp + 8]
		call writeString
		call Crlf
		call Crlf
		mov		edx, [ebp + 12]
		call writeString
		call Crlf
		call Crlf
	pop ebp
	ret 8
Introduction ENDP



;****************************************************************
; Title: getData
; Description: Stores user input in the request variable
; Parameters: MAX, MIN, errorMessage (str), promptUser (str), request (int)
; Returns: Stores user input in the request variable
; Registers changed: ebx, edx, eax
;****************************************************************
getData PROC
	push ebp
	mov		ebp, esp
	mov		ebx, [ebp + 8]

	; Prompt user for input
		input:
			mov		edx, [ebp + 12]		
			call writeString 
			call readInt
			call checkInput						; Calls checkInput to validate input
	pop ebp
	ret 4
getData ENDP


;****************************************************************
; Title: displayList
; Description: Prints out list, 5 numbers per line
; Parameters: space	(str), request (int), array, unsorted OR sorted (str)
; Returns: List of random numbers, 5 numbers per line
; Registers changed: ebx, ecx, edx, eax, edi
;****************************************************************
displayList PROC
	push ebp
	mov		ebp, esp
	mov		ecx, [ebp + 16]						; Put request into ecx for loop count (source: lecture 19 slides)
	mov		edi, [ebp + 12]						; Put address of list into edi (source: lecture 19 slides)
	mov		edx, [ebp + 8]						; Put string for list title into edx

	; Print list title
	call writeString
	call Crlf

	print:
		; Start new line every 5 numbers
		mov		eax, [ebp + 16]
		sub		eax, ecx
		mov		ebx, 5
		cdq
		div ebx
		cmp eax, 0
		je continue
		cmp edx, 0
		je nextLine
		jmp continue

		nextLine:
			call Crlf

		continue:
			mov		eax, [edi]
			call writeDec
			mov		edx, [ebp + 20]						; Print space between numbers
			call writeString
			add edi, 4									; Increment to next array index
	loop print

	call Crlf
	call Crlf

	pop ebp
	ret 16
displayList ENDP

END