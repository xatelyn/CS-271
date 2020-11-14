Include Irvine32.inc

.data

.code


;****************************************************************
; Title: checkInput
; Description: Called by getData to check if user input is within bounds
; Parameters (from getData): MAX, MIN, errorMessage (str), promptUser (str), request (int)
; Returns: Stores VALID user input in the request variable
; Registers changed: ebx, edx, eax
;****************************************************************
checkInput PROC
	jmp check

	input:
		mov		edx, [ebp + 12]				; Reprompt user for input
		call writeString 
		call readInt

	check:									
		cmp eax, [ebp + 20]
		jl error							; if number is invalid, jump to error message
		cmp eax, [ebp + 24]
		jg error
		jmp continue						; if number is valid, skip over error message

	error:
		mov		edx, [ebp + 16]
		call writeString
		call Crlf
		jmp input							; jump to reprompt user for input

	continue:
		mov		[ebx], eax				
		call Crlf
	ret
checkInput ENDP


;****************************************************************
; Title: fillArray
; Description: Fills array with random numbers from 64-1024
; Parameters: HI, LO, request (int), array
; Returns: no returns, just fills the array
; Registers changed: ecx, edi, eax
;****************************************************************
fillArray PROC
	push ebp
	mov		ebp, esp
	mov		ecx, [ebp + 12]						; Put request into ecx for loop count (source: lecture 19 slides)
	mov		edi, [ebp + 8]						; Put address of list into edi (source: lecture 19 slides)
	call Randomize
	fill:
		; get random number in eax (source: lecture 20 slides)
		mov		eax, [ebp + 20]							; 1024
		sub	eax, [ebp + 16]								; 1024 - 64 = 960
		inc	eax											; 961
		call RandomRange								; eax in [0..960]
		add eax, [ebp + 16]								; eax in [64..1024]

		mov		[edi],eax
		add edi, 4										; increment to access next array element
		loop fill

	pop ebp
	ret 8
fillArray ENDP

;****************************************************************
; Title: sortArray
; Description: Sorts array in descending order (highest to lowest)
; Parameters: array, request(int)
; Returns: Selection sorted array
; Registers changed: ecx, edi, eax, edx, ebx
;****************************************************************
sortArray PROC
	
	;Set up for proc and init variables
	push	ebp
	mov		ebp, esp
	mov		ecx, [ebp + 8]		; request
	dec	ecx						; Outer loop count: for(k=0; k<request-1; k++)
	mov		edi, [ebp + 12]		; list

	outer_loop:
		push	ecx				; store outer loop count
		mov		eax, [edi]		; get current element
		mov		edx, edi		; i=k
		
		inner_loop:
			mov		ebx, [edi + 4]			; list[j]
			mov		eax, [edx]				; list[i]
			cmp	eax, ebx				; Compare list[j] to list[i]

			jge	noExchange				; If list[i] >= list[j] ax >= ebx, don't swap
			call exchange					; Else, swap

			noExchange:
			add	edi, 4					; increment to next array index
			loop inner_loop

		pop		ecx						; Restore outer loop count		
		mov		edi, edx
		add	edi, 4
		loop	outer_loop




	pop		ebp		
	ret		8
sortArray ENDP

;****************************************************************
; Title: exchange
; Description: Called by sortArray to swap values between two array indexes
; Parameters: array
; Returns: exchanges values of two array indexes
; Registers changed: ebx, edx, eax, edi
;****************************************************************
exchange PROC
	mov		[edx], ebx
	mov		[edi + 4], eax

ret
exchange ENDP


;****************************************************************
; Title: displayMedian
; Description: Calculates and prints median
; Parameters: median (str), array, request (int)
; Returns: Prints median
; Registers changed: ebx, edx, eax, edi
;****************************************************************
displayMedian PROC
	push	ebp
	mov		ebp, esp
	mov		edi, [ebp + 8]				; array
	mov		eax, [ebp + 12]				; request

	mov		ebx, 2
	cdq
	div ebx								; divide request by 2
	cmp edx, 0							; if remainder is 0 it's even, if not 0 it's odd
	jne odd

	; if request is even
		mov		ebx, 4
		mul	ebx							; multiply by 4 to get to the right middle index
		add edi, eax					; increment to the right middle index
		mov		eax, [edi]				
		add		eax, [edi - 4]			; add two middle indexes together
		mov		ebx, 2
		div	ebx							; divide by 2 to get the average of the two middle numbers
		cmp edx, 0
		je print						; if there's no remainder, print number
		inc eax							; if there's a remainder (0.5), round up
		jmp print
		
	; if request is odd
	odd:								
		mov		ebx, 4					
		mul	ebx							; multiply middle request num by 4
		add edi, eax					; add to edi to get to middle index
		mov		eax, [edi]

	print:
		mov		edx, [ebp + 16]			; string to display "the median is"
		call writeString					
		call writeDec					; prints median #
		call Crlf

	pop ebp
	ret 12
displayMedian ENDP



;****************************************************************
; Title: displayAverage
; Description: Calculates and prints average
; Parameters: average (str), array, request (int)
; Returns: Prints average
; Registers changed: ebx, ecx, edx, eax, edi
;****************************************************************
displayAverage PROC
	push	ebp
	mov		ebp, esp
	mov		edi, [ebp + 8]				; array	
	mov		ecx, [ebp + 12]				; request
	mov		eax, 0						; reset eax to 0
			
	accumulate:
		add eax, [edi]					; add all the array elements together
		add edi, 4
	loop accumulate

		mov ebx, [ebp + 12]
		cdq
		div ebx							; divide by request (int) to get the average

		mov		edx, [ebp + 16]			; string to display "the average is"
		call writeString
		call writeDec
		call Crlf
		call Crlf

	pop ebp
	ret 12
displayAverage ENDP

END