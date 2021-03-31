###########################################################################
# Created by: Kanuma, Midori
# mkanuma
# 18/November 2018
#
# Assignment: Lab 4: ACII conversion and prints
# CMPE 012, Computer Systems and Assembly Language
# UC Santa Cruz, Fall 2018
#
# Description: This program takes the two program arguments, converts them
#              into binary, adds them together, prints the sum as decimal
#              represented in ASCII, prints it as the binary number(also
#              ASCII), then finally prints it as morse code. 
#
# Notes:       This program is intended to be run from the MARS IDE.
#              I was trying to align all of the comments but when I was only half way
#              after 10 minutes of indenting, I gave up. Please forgive me.
############################################################################

################################################## Begin Pseudocode
# $s1 = getProgramArgument( $a1 )                # Fetches the first program argument and saves it in s1
# $s2 = getProgramArgument( $a1 + 4 )            # Fetches the next program argument and saves it in s2
#
# PrintString( Prompt1 )                         # Prints: "You inputted...
# PrintString( $s1 )                             # First number
# PrintChar( " " )                               # Space character
# PrintString( $s2 )                             # Second number
#
# $t1 = convertASCIItoBinary( $s1 )              # Converts the ASCII number into 2's complement binary
# $t2 = convertASCIItoBinary( $s2 )              # Converts the ASCII number into 2's complement binary
#
# $s1 = $t1                                      # Saves temp register value into a save register
# $s2 = $t2                                      # Saves temp register value into a save register
# $s0 = $s1 + $s2                                # Saves the sum into a save register
#
# $t0 = convertBinarytoDecimal( $s0 )            # Converts sum into human readable number(int)
# $t1 = convertDecimaltoASCII( $t0 )             # Converts sum into string so we can print string
#
# PrintString( Prompt2 )                         # Prints: "The sum in decimal is...
# PrintString( $t1 )                             # The sum
#
# $t0 = $s0                                      # Brings back value of sum
# $t1 = convertBinarytoASCII( $t0 )              # Convert into String
#
# PrintString( Prompt3 )                         # Prints: "The sum in binary is...
# PrintString( $t1 )                             # The sum
# 
# exit                                           # Ends the program
#
################################################## End Pseudocode

################################################## Register Usage
# $s0: used to store the sum in binary
# $s1: used to store program argument A in binary
# $s2: used to store program argument B in binary
# $t1-$t3: used for loads and stores
# $t2,$t6: used for counters in loops
# $t3,$t4 and $t5: used to store the divisor, hi and the lo for multiplication adn division
################################################## End Register Usage

################################################## Begin the actual code

# "-"       : 2D
# " "       : 20
# "."       : 2E
# 0~9       : 30~39
# Syscall 4 : Print String : Prints string starting from address at $a0 until null terminator.
# Syscall 11: Print Char   : Reads and prints value in $a0 as an ASCII character.

.data

Prompt1: .asciiz "You entered the decimal numbers:"            
Prompt2: .asciiz "The sum in decimal is:"
Prompt3: .asciiz "The sum in two's complement binary is:"
Prompt4: .asciiz "The sum in Morse code is:"
NL:      .asciiz "\n"
SP:      .asciiz " "
HP:      .asciiz "-"
M0:      .asciiz "-----"
M1:      .asciiz ".----"
M2:      .asciiz "..---"
M3:      .asciiz "...--"
M4:      .asciiz "....-"
M5:      .asciiz "....."
M6:      .asciiz "-...."
M7:      .asciiz "--..."
M8:      .asciiz "---.."
M9:      .asciiz "----."
MH:      .asciiz "-....-"

.text

bne   $a0 2 exit                                 # Exits if number of program argument is not equal to 2 
nop

addi  $s0 $zero 0
addi  $s1 $zero 0                                # Initializes $s0, $s1 and $s2 at 0
addi  $s2 $zero 0

lw    $t1 ($a1)                                  # Address of the first program argument
lw    $t2  4($a1)                                # Address of the second program argument

################################################## We have fetched the addresses of both program arguments

first: nop                         
      lb   $t3 ($t1)                             # Adds the first byte of prog arg into LSB of $s1
      add  $s1 $s1   $t3
      
      lb   $t3 1($t1)                            # Check if reached the null terminator
      beq  $t3 $zero next
      nop
      sll  $t3 $t3   8                           # Adds the second byte of prog arg into the second LSB of $s1
      add  $s1 $s1   $t3
      nop
      
      lb   $t3 2($t1)                            # Check if reached the null terminator
      beq  $t3 $zero next
      nop
      sll  $t3 $t3   16                          # Adds the third byte of prog arg into the third LSB of $s1
      add  $s1 $s1   $t3
      nop
      
      lb   $t3 3($t1)                            # Check if reached the null terminator
      beq  $t3 $zero next
      nop
      sll  $t3 $t3   24                          # Adds the last byte of prog arg into MSB of $s1
      add  $s1 $s1   $t3
      nop
        
next: nop                                        # Once we find the null terminator, we move back down 1
      sw   $s1 ($a1)
      
second: nop                         
       lb   $t3 ($t2)                            # Repeat what's in first: , but for second prog arg and $s2
       add  $s2 $s2   $t3
       
       lb   $t3 1($t2)
       beq  $t3 $zero next0
       nop
       sll  $t3 $t3   8
       add  $s2 $s2   $t3
       nop
      
       lb   $t3 2($t2)
       beq  $t3 $zero next0
       nop
       sll  $t3 $t3   16
       add  $s2 $s2   $t3
       nop
      
       lb   $t3 3($t2)
       beq  $t3 $zero next0
       nop
       sll  $t3 $t3   24
       add  $s2 $s2   $t3
       nop
        
next0: nop                                       # Once we find the null terminator, we move back down 1
       sw   $s2 4($a1)

la    $a0 Prompt1                                # Prints the first prompt
addi  $v0 $zero 4
syscall

la    $a0 NL                                     # Prints a new line
syscall

la    $a0 ($a1)                                  # Prints first prog arg
syscall

la    $a0 SP                                     # Prints space
syscall

la    $a0 4($a1)                                 # Prints second prog arg
syscall

la    $a0 NL                                     # Prints new line
syscall
syscall

################################################## We have printed the first prompt and the two program arguments

addi  $s1 $zero 0                                # initializes $s1 and $s2 at 0 again
addi  $s2 $zero 0

add   $t1 $a1 $zero                              # Sets $t1 as address where the prog arg is stored
lb    $t3 ($t1)                   
bne   $t3 0x2d beginplusloop                     # if first character is not "-", skip to beginplusloop
nop

addi  $t1 $t1   1                                # if there is a "-", move over to the next char
addi  $t2 $zero 0                                # Sets $t2 at 0. This is the counter to find how many character is in the negative number

minusloop: nop
           lb  $t3 ($t1)                         # Keeps going up the address until null terminator is reached
           beq $t3 $zero nextminus
           nop
           
           addi $t1 $t1 1                        # When exit loop, $t1 = address of the null terminator
           addi $t2 $t2 1                        # When exit loop, $t2 = # of chars
           j    minusloop
           
nextminus: nop
           subi $t1 $t1 1                        # Move back one from the null terminator
           
           lb   $t3 ($t1)                        # Load the first digit of minus number(ASCII) and mask the second hex e.g. 0x32 -> 0x02
           and  $t3 $t3 0x0000000f  
           add  $s1 $s1 $t3                      # Add the first digit to $s1
           
           subi $t1 $t1 1                        # Move to second digit of the minus number
           subi $t2 $t2 1                        # subtract from number of character
           
           beq  $t2 $zero nextnextminus          # If the minus char is one character w/o the "-", go to nextnextminus:
           nop
           
           lb   $t3 ($t1)                        # Load second digit of minus number and mask it
           and  $t3 $t3   0x0000000f     
           addi $t4 $zero 0x0000000a             # Since this is 10's digit, multiply by 10(0xa)
           mult $t3 $t4                 
           mflo $t3
           add  $s1 $s1 $t3                      # Add that to the $s1
           
           subi $t1 $t1 1                        # Move to third digit of the minus number
           subi $t2 $t2 1                        # subtract from number of character
           
           beq  $t2 $zero nextnextminus          # If the minus char is two character w/o the "-", go to nextnextminus:
           nop
           
           lb   $t3 ($t1)                        # Load second digit of minus number and mask it
           and  $t3 $t3   0x0000000f     
           addi $t4 $zero 0x00000064             # Since this is 100's digit, multiply by 100(0x64)
           mult $t3 $t4                 
           mflo $t3
           add  $s1 $s1 $t3                      # Add that to the $s1

nextnextminus: nop
               not   $s1 $s1                     # Invert the bits and add one (Two's complement operation)
               addi  $s1 $s1 1
               j     firstdone
                                                                                                                                              
beginplusloop: nop
               lb  $t3 ($t1)                     # Keeps going up the address until null terminator is reached
               beq $t3 $zero nextplus
               nop
           
               addi $t1 $t1 1                    # When exit loop, $t1 = address of the null terminator
               addi $t2 $t2 1                    # When exit loop, $t2 = # of chars
               j    beginplusloop
               
nextplus:      nop
               subi $t1 $t1 1                    # Move back one from the null terminator
           
               lb   $t3 ($t1)                    # Load the first digit of minus number(ASCII) and mask the second hex e.g. 0x32 -> 0x02
               and  $t3 $t3 0x0000000f  
               add  $s1 $s1 $t3                  # Add the first digit to $s1
           
               subi $t1 $t1 1                    # Move to second digit of the minus number
               subi $t2 $t2 1                    # subtract from number of character
           
               beq  $t2 $zero firstdone          # If the minus char is one character w/o the "-", go to nextnextminus:
               nop
           
               lb   $t3 ($t1)                    # Load second digit of minus number and mask it
               and  $t3 $t3   0x0000000f     
               addi $t4 $zero 0x0000000a         # Since this is 10's digit, multiply by 10(0xa)
               mult $t3 $t4                 
               mflo $t3
               add  $s1 $s1 $t3                  # Add that to the $s1
           
               subi $t1 $t1 1                    # Move to third digit of the minus number
               subi $t2 $t2 1                    # subtract from number of character
            
               beq  $t2 $zero firstdone          # If the minus char is two character w/o the "-", go to nextnextminus:
               nop
           
               lb   $t3 ($t1)                    # Load second digit of minus number and mask it
               and  $t3 $t3   0x0000000f     
               addi $t4 $zero 0x00000064         # Since this is 100's digit, multiply by 100(0x64)
               mult $t3 $t4                 
               mflo $t3
               add  $s1 $s1 $t3

firstdone:     nop

################################################## We have stored the two's complement representation of prog arg A into $s1

add   $t1 $a1 4                                  # Sets $t1 as address where the prog arg is stored
lb    $t3 ($t1)                   
bne   $t3 0x2d beginplusloop0                    # if first character is not "-", skip to beginplusloop
nop

addi  $t1 $t1   1                                # if there is a "-", move over to the next char
addi  $t2 $zero 0                                # Sets $t2 at 0. This is the counter to find how many character is in the negative number

minusloop0: nop
            lb  $t3 ($t1)              # Keeps going up the address until null terminator is reached
            beq $t3 $zero nextminus0
            nop
           
            addi $t1 $t1 1             # When exit loop, $t1 = address of the null terminator
            addi $t2 $t2 1             # When exit loop, $t2 = # of chars
            j    minusloop0
           
nextminus0: nop
            subi $t1 $t1 1             # Move back one from the null terminator
           
            lb   $t3 ($t1)             # Load the first digit of minus number(ASCII) and mask the second hex e.g. 0x32 -> 0x02
            and  $t3 $t3 0x0000000f  
            add  $s2 $s2 $t3           # Add the first digit to $s1
             
            subi $t1 $t1 1             # Move to second digit of the minus number
            subi $t2 $t2 1             # subtract from number of character
           
            beq  $t2 $zero nextnextminus0  # If the minus char is one character w/o the "-", go to nextnextminus:
            nop
           
            lb   $t3 ($t1)                # Load second digit of minus number and mask it
            and  $t3 $t3   0x0000000f     
            addi $t4 $zero 0x0000000a     # Since this is 10's digit, multiply by 10(0xa)
            mult $t3 $t4                 
            mflo $t3
            add  $s2 $s2 $t3              # Add that to the $s1
           
            subi $t1 $t1 1             # Move to third digit of the minus number
            subi $t2 $t2 1             # subtract from number of character
           
            beq  $t2 $zero nextnextminus0  # If the minus char is two character w/o the "-", go to nextnextminus:
            nop
           
            lb   $t3 ($t1)                # Load second digit of minus number and mask it
            and  $t3 $t3   0x0000000f     
            addi $t4 $zero 0x00000064     # Since this is 100's digit, multiply by 100(0x64)
            mult $t3 $t4                 
            mflo $t3
            add  $s2 $s2 $t3              # Add that to the $s1

nextnextminus0: nop
                not   $s2 $s2             # Invert the bits and add one (Two's complement operation)
                addi  $s2 $s2 1
                j     seconddone
                                                                                                                                              
beginplusloop0: nop
                lb  $t3 ($t1)              # Keeps going up the address until null terminator is reached
                beq $t3 $zero nextplus0
                nop
           
                addi $t1 $t1 1             # When exit loop, $t1 = address of the null terminator
                addi $t2 $t2 1             # When exit loop, $t2 = # of chars
                j    beginplusloop0
               
nextplus0:     nop
               subi $t1 $t1 1             # Move back one from the null terminator
           
               lb   $t3 ($t1)             # Load the first digit of minus number(ASCII) and mask the second hex e.g. 0x32 -> 0x02
               and  $t3 $t3 0x0000000f  
               add  $s2 $s2 $t3           # Add the first digit to $s1
           
               subi $t1 $t1 1             # Move to second digit of the minus number
               subi $t2 $t2 1             # subtract from number of character
           
               beq  $t2 $zero seconddone  # If the minus char is one character w/o the "-", go to nextnextminus:
               nop
           
               lb   $t3 ($t1)                # Load second digit of minus number and mask it
               and  $t3 $t3   0x0000000f     
               addi $t4 $zero 0x0000000a     # Since this is 10's digit, multiply by 10(0xa)
               mult $t3 $t4                 
               mflo $t3
               add  $s2 $s2 $t3              # Add that to the $s1
           
               subi $t1 $t1 1             # Move to third digit of the minus number
               subi $t2 $t2 1             # subtract from number of character
            
               beq  $t2 $zero seconddone  # If the minus char is two character w/o the "-", go to nextnextminus:
               nop
           
               lb   $t3 ($t1)                # Load second digit of minus number and mask it
               and  $t3 $t3   0x0000000f     
               addi $t4 $zero 0x00000064     # Since this is 100's digit, multiply by 100(0x64)
               mult $t3 $t4                 
               mflo $t3
               add  $s2 $s2 $t3

seconddone:    nop

############################################### We have stored the two's complement representation of program argument B into $s2

add $s0 $s1 $s2              # Finds the two's complement sum and stores it in $s0

############################################### We have found the sum

la    $a0 Prompt2            # Prints the second prompt
addi  $v0 $zero 4
syscall

la    $a0 NL                 # Prints new line
syscall

sw    $s0 ($a1)                  # Store the sum in where program arguent A used to be

add   $t5 $s0 $zero              # Sets t1 as sum
andi  $t5 $t5 0x80000000         # Masks the MSbit of sum

#lb  $t3 3($a1)                 # Loads the most significant byte of sum into $t3
#srl $t3 $t3 7                  # Shift right 7 bits so the least significant bit is the most significant bit of the sum

sw  $zero 4($a1)               # initializes address of program argument B as 0
lw  $t3   ($a1)                # Loads the sum(binary) into t3

add $t1 $a1 4                  # Sets t1 as the address where we store the inverted ascii string
li  $t2 0                      # Initialize counter at 0  
li  $t4 0xa                    # Sets the divisor as 10(0xa)

bne $t5 0x80000000 storeloop    # branch to positive if the most significant bit is not 1
nop

negative: nop
          la  $a0 HP   # Prints the hyphen
          li  $v0 4
          syscall
            
          not   $t3 $t3        # Does the two's complement operation on sum
          addi  $t3 $t3 1
          
storeloop: nop
           div   $t3 $t4        # divides $t3 by 10
          
           mflo  $t3            # Stores the quotient in $t3
           mfhi  $t5            # Stores the remainder in $t5
           
           addi  $t5 $t5   0x30   # Converts the remainder to ASCII equivalent
           sb    $t5 ($t1)        # Stores the char in prog arg B area
          
           addi  $t1 $t1 1      # Increments the address by 1
           addi  $t2 $t2 1      # Increments counter by 1
           
           beq   $t3 0 donestoring  # If quotient is 0, done storing
           nop
          
           j     storeloop         # loop
          

donestoring: nop
             subi $t1 $t1 1              # Move back one character
             li   $v0 11                 # Sets the syscall for print char
           
printloop:   nop
             lb   $a0 ($t1)              # Loads the byte(ASCII)
             syscall                     # Prints
             
             subi $t2 $t2 1              # Decrease the address
             subi $t1 $t1 1              # Decrease the counter
             
             beq  $t2 0   doneprinting   # Done printing if counter = 0
             nop
             
             j    printloop              # loop
             
doneprinting: nop
              la   $a0 NL                # Prints new line twice
              li   $v0 4
              syscall
              syscall
             
###################################################### We've printed the decmal sum

la    $a0 Prompt3            # Prints the third prompt
addi  $v0 $zero 4
syscall

la    $a0 NL                 # Prints new line 
syscall

move  $t1 $s0                # Sets t1 as sum(binary)
li    $t3 0x00000001         # Makes the mask that masks the MSB
li    $t2 -1                 # Initialize counter at -1
li    $v0 11               

binprintloop: nop
              addi $t2 $t2 1  # increments the counter
              
              beq  $t2 32 bindone  # done printing binary if counter reaches 32
              nop
              
              ror  $t3 $t3 1       # Rotate the mask to the right once
              and  $t4 $t1 $t3     # $t4 now points at the specific bit that we masked
              
              beq  $t4 0 zero      # Skip to zero if the bit is zero
              nop
              
one:          nop
              li   $a0 0x31
              syscall
              
              j    binprintloop
              

zero:         nop
              li   $a0 0x30
              syscall  
              
              j    binprintloop 
              
bindone:      nop
              li   $a0 0xa
              syscall
              syscall
              
########################################################## We have printed the binary sum            
                                                   
la    $a0 Prompt4            # Prints the fourth prompt
addi  $v0 $zero 4
syscall

la    $a0 NL                 # Prints new line
syscall

move  $t1     $s0                # Loads the sum
li    $t5     0xa                # Loads the divisor 10 into t5
sw    $zero   ($a1)              # Resets area at $a1 to 0
move  $t4     $a1                # Adress
li    $t6     0                  # counter = 0

checksign: nop
           andi $t2 $t1 0x80000000     # masking the MSB to check
           beq  $t2 0   skiphyphen
           nop
           
           la   $a0 MH                # printing hyphen in morse
           syscall
           
           la   $a0 SP                # print a space after the hyphen
           syscall
           
           not  $t1 $t1              # 2SC operation
           addi $t1 $t1 1
           
skiphyphen: nop
            li  $t2 0
            
morsestore: nop
            div  $t1 $t5                # Division
            mflo $t1                    # Quotient
            mfhi $t2                    # Modulus
            
            sb   $t2 ($t4)              # Store the number, then move address over by one
            addi $t4 $t4 1
            
            addi $t6 $t6 1              # increment counter
            
            beq  $t1 0   morsenext      # go to next if quotient is 0
            nop
            
            j    morsestore             # loop

morsenext:  nop
            subi  $t4 $t4 1              # Move to the most significant digit
           
morseprint: nop
            beq   $t6 0 morsedone        # exit if counter reaches 0
            nop
            
            lb    $t2 ($t4)              # load the digit
            
            beq   $t2 0 print0m          # These are the branch statements to the label for printing the morse code
            nop
            beq   $t2 1 print1m
            nop
            beq   $t2 2 print2m
            nop
            beq   $t2 3 print3m
            nop
            beq   $t2 4 print4m
            nop
            beq   $t2 5 print5m
            nop
            beq   $t2 6 print6m
            nop
            beq   $t2 7 print7m
            nop
            beq   $t2 8 print8m
            nop
            beq   $t2 9 print9m
            nop
            
            flag: nop
            
            subi  $t6 $t6 1                   # Decreases the counter and the address by 1
            subi  $t4 $t4 1
            
            bne   $t6 0   printspace          # If counter is not zero at this point, print space
            nop
            
            galf: nop
           
            j     morseprint
            
morsedone:  nop 
            la    $a0 NL
            syscall                            # Prints the final newline

exit: nop                               # Exits the program
      addi $v0 $zero 10
      syscall
      
################################################# Successfully printed everything     
 
print0m: nop
         la   $a0  M0                   # These are the print labels for the morse code
         syscall
         j    flag
         
print1m: nop
         la   $a0  M1
         syscall
         j    flag
         
print2m: nop
         la   $a0  M2
         syscall
         j    flag
         
print3m: nop
         la   $a0  M3
         syscall
         j    flag
         
print4m: nop
         la   $a0  M4
         syscall
         j    flag
         
print5m: nop
         la   $a0  M5
         syscall
         j    flag
         
print6m: nop
         la   $a0  M6
         syscall
         j    flag
         
print7m: nop
         la   $a0  M7
         syscall
         j    flag
         
print8m: nop
         la   $a0  M8
         syscall
         j    flag
         
print9m: nop
         la   $a0  M9
         syscall
         j    flag
         
printspace: nop
            la   $a0  SP
            syscall
            j    galf
################################################# Absolute end of code. Nothing to see below. You're still here? Go home. Go!




