CS 271 Computer Architecture and Assembly Language

Programming Assignment #3

Objectives:

    1. Implementing data validation
    
    2. Implementing anaccumulator
    
    3. Integer arithmetic
    
    4. Defining variables (integer and string)
    
    5. Using library procedures for I/O
    
    6. Implementing control structures (decision, loop, procedure)
    
 Description:
 
 Write and test a MASM program to perform the following tasks:
 
    1. Display the program title and programmer’s name.
    
    2. Get the user’s name, and greet the user.
     
    3. Display instructions for the user.
     
    4. Repeatedly prompt the user to enter a number.  
      
          Validate the user input to be in [-100, -1] (inclusive).  
          
          Count and accumulate the valid usernumbers until a non-negative number is entered.  (The non-negativenumber is discarded.)
          
     5. Calculate the (rounded integer) average of the negative numbers.
      
     6. Display:
      
          i.the number of negative numbers entered(Note: if no negative numbers were entered, display a special message and skip to iv.)
          
          ii.the sum of negative numbers entered
          
          iii.the average,rounded to the nearest integer(e.g. -20.5 rounds to -21; 20.5 rounds to 21)
          
          iv.a parting message(with the user’s name)
