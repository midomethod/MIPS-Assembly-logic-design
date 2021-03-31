####################################################################################
# Created by: Kanuma, Midori
# mkanuma
# 31 October 2018
#
# Assignment: Lab 3: Flux Bunny loop in MIPS assembly language
# CMPE 012, Computer Systems and Assembly Language
# UC Santa Cruz, Fall 2018
#
# Description: This program takes the user input and prints "Flux" for numbers that are multiples of 5,
#              "Bunny" for numbers that are multiples of 7, and prints the number itself otherwise.
#
# Notes: This program is intended to be run from the MARS IDE.
####################################################################################

.data

 prompt:     .asciiz "Please input a positive integer: "
 Flux:       .asciiz "Flux"
 Bunny:      .asciiz "Bunny"
 Space:      .asciiz " "
 New_Line:   .asciiz "\n"
 
 # REGISTER USAGE
 # $v0: used for syscall
 # $a0: used for syscall
 # $t0: stores the end value
 # $t1: stores the remainder for division by 5
 # $t2: stores the counter for loop
 # $t3: stores the remainder for division by 7
 # $t4: stores the (t2%5)AND(t2%7)
 # $t5: stores the value 5
 # $t7: stores the value 7
 
      .text
      
main:           nop      
                addi        $t5 $zero  5                 #initializes numbers 5 and 7
                addi        $t7 $zero  7

                addi        $v0 $zero  4                 # Prints the prompt
                la          $a0 prompt
                syscall

                addi        $v0 $zero  5                 # Reads the user input(integer),
                syscall
                add         $t0 $zero  $v0               # then stores it in a register
 
                add         $t2 $zero  $zero             # Sets $t2 at 0 before beginning the loop
 
 FB_Loop:       nop
                div         $t2 $t5                      # Divides counter by 5
                mfhi        $t1                          # then stores the remainder    
             
                div         $t2 $t7                      # Divides counter by 7
                mfhi        $t3                          # then stores the remainder
             
                beq         $t1 $zero  Print_Flux        # Prints Flux if modulus(/5) is 0
                
                FBL_part2:  nop
                
                OR          $t4 $t1    $t3               # Print a space character if both are true
                beq         $t4 $zero  Print_Space
                
                FBL_part3:  nop
                
                beq         $t3 $zero  Print_Bunny       # Prints Bunny if modulus(/7) is 0
                
                FBL_part4:  nop
                
                bne         $t1 $zero  Print_N1          # Branch to check for t2%7 if t2%5 is not zero 
                
                FBL_part5:  nop
                
                j           Print_Newline                # Prints New Line charcter all the time
                
                FBL_part6:  nop
                
                beq         $t2 $t0    End_Run           # Branches to end run if the counter reaches maximum
             
                addi        $t2 $t2    1                 # Increments the counter by 1
             
                j           FB_Loop                      # Jumps to the beginning of the loop
             
 Print_Flux:    nop
                addi        $v0 $zero  4                 # Prints "Flux"
                la          $a0 Flux
                syscall
                j           FBL_part2                    # Then jumps back to the loop
              
 Print_Space:   nop
                addi        $v0 $zero  4                 # Prints a space character
                la          $a0 Space 
                syscall   
                j           FBL_part3                    # Then jumps back to the loop
                        
 Print_Bunny:   nop  
                addi        $v0 $zero  4                 # Prints "Bunny"
                la          $a0 Bunny
                syscall
                j           FBL_part4                    # Then jumps back to the loop
                
 Print_N1:      nop
                bne         $t3 $zero  Print_N2          # Branches to Print part 2 if t2%7 is also not zero
                j           FBL_part5                    # jumps back to loop if failed to branch
              
 Print_N2:      nop                                  
                addi        $v0 $zero  1                 # Parints the number, then jumps back to the loop
                add         $a0 $zero  $t2
                syscall
                j           FBL_part5                    # jumps back to the loop
 
 Print_Newline: nop                                     
                addi        $v0 $zero  4                 # Prints the new line character       
                la          $a0 New_Line
                syscall
                j           FBL_part6                    # Then jumps back to the loop
                
 End_Run:       nop                                 
                addi        $v0 $zero  10                # Ends the program
                syscall

 


 
