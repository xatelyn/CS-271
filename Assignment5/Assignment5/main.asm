; Author: Katelyn Nguyen - CS 271
; Program: Assignment #5
; Date: 11/8/2020
; Description: This program generates random numbers between 64 & 1024, displays the original & sorted list, and calculates the median & average value.

INCLUDE Irvine32.inc
INCLUDE program_io.inc
INCLUDE algorithm.inc

; constants
MIN	=	16
MAX	=	256
LO	=	64
HI	=	1024


.data
progTitle			BYTE	"Sorting Random Integers	Programmed by Katelyn Nguyen", 0
progDescription		BYTE	"This program generates random numbers in the range [64, 1024], displays the original", 10, 13
					BYTE	"list, sorts the list, and calculates the median value and the average value. Finally," , 10, 13
					BYTE	"it displays the list sorted in descending order." , 0
promptUser			BYTE	"How many numbers should be generated? [16, 256]: " , 0
errorMessage		BYTE	"Invalid input", 0
unsorted			BYTE	"Unsorted random numbers: ", 0
sorted				BYTE	"Sorted list: ", 0
space				BYTE	"  ", 0
median				BYTE	"The median is ", 0
average				BYTE	"The average is ", 0


request				DWORD 0
array				DWORD  MAX    DUP(?)
outerLoop			DWORD 0




.code
main PROC

; Call procedure to display introduction
	push OFFSET progTitle
	push OFFSET progDescription
	call Introduction
	
; Call procedure to get user input for amount of numbers to print 
	push MAX
	push MIN
	push OFFSET errorMessage
	push OFFSET promptUser
	push OFFSET request			
	call getData

; Call procedure to fill array with random numbers
	push HI
	push LO
	push request					
	push OFFSET	array			
	call fillArray

; Call procedure to print unsorted array
	push OFFSET space			
	push request					
	push OFFSET	array			
	push OFFSET	unsorted		
	call displayList

; Call procedure to sort array
	push OFFSET	array			
	push request					
	call sortArray


; Call procedure to print median
	push OFFSET median			
	push request	
	push OFFSET	array
	call displayMedian

; Call procedure to print average
	push OFFSET average			
	push request	
	push OFFSET	array
	call displayAverage

; Call procedure to print sorted list
	push OFFSET space			
	push request					
	push OFFSET	array			
	push OFFSET	sorted
	call displayList




exit  ; exit to operating system
main ENDP
END main