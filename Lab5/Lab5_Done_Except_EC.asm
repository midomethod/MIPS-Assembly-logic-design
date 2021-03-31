###############################################################################################


.text
#--------------------------------------------------------------------
# give_type_prompt
#
# input: $a0 - address of type prompt to be printed to user
#
# output: $v0 - lower 32 bit of time prompt was given in milliseconds
#--------------------------------------------------------------------
give_type_prompt:             nop
                              
                              subi      $sp       $sp       4           # Push $a0 to stack
                              sw        $a0       ($sp)
                              
                              li        $v0       4                     # At this point, $a0 already contains the address of the type prompt
                              syscall
                              
                              li        $v0       30
                              syscall
                              
                              move      $v0       $a0                   # Move $a0 to $v0
                              
                              lw        $a0       ($sp)                 # Pop and load the original $a0
                              addi      $sp       $sp       4
                              
                              jr        $ra
                              
#--------------------------------------------------------------------
# check_user_input_string
#
# input: $a0 - address of type prompt printed to user
# $a1 - time type prompt was given to user
# $a2 - contains amount of time allowed for response
#
# output: $v0 - success or loss value (1 or 0)
# Check for the completion time and
# also run the compare_strings
#--------------------------------------------------------------------
check_user_input_string:      nop
                              subi      $sp       $sp       4            # push $ra to stack
                              sw        $ra       ($sp)
                              
                              move      $t1       $a1                    # Keep track of system time 1
                              move      $t3       $a0                    # Keep address of prompt in $t3
                              
                              la        $a0       space_allocated        # Stores the user input at address in $a0
                              la        $t2       space_allocated        # Stores the same address in $t2
                              li        $a1       100
                              li        $v0       8
                              syscall
                              
                              li        $v0       30                     # get system time after user inputs the string
                              syscall
                              
                              move      $a1       $t1                    # The system time 1
                              
                              sub       $a1       $a0       $a1          # Finds the time it took for the user to input string = (systime 2 - systime 1)
                              
                              bgt       $a1       $a2       setToZero    # Lose if the time it took is greater than the time allowed
                              nop
                              
                              move      $a0       $t2                    # Puts the first address in $a0  
                              move      $a1       $t3                    # Puts the second address in $a1
                              
                              jal       compare_strings
                              
                              beq       $v0       0         setToZero    # If the strings are not equal, set $v0 to 0
                              nop        
                             
                              setToOne:           nop
                                                  li        $v0       1
                                                  j         skipp
                                                  
                              setToZero:          nop
                                                  li        $v0       0
                                                 
                                                  
                              skipp:              nop
                              
                    
                              lw        $ra       ($sp)
                              addi      $sp       $sp       4
                              jr        $ra
                    
#--------------------------------------------------------------------
# compare_strings
#
# input: $a0 - address of first string to compare
# $a1 - address of second string to compare
#
# output: $v0 - comparison result (1 == strings the same, 0 == strings not the same)
#--------------------------------------------------------------------
compare_strings:    nop
                    subi      $sp       $sp       4
                    sw        $ra       ($sp)
                    
                    move      $t3       $a0
                    move      $t4       $a1
                    
                    comcha:   nop
                              lb        $t1       ($t3)
                              lb        $t2       ($t4)
                              
                              beqz      $t1       next
                              nop
                              
                              move      $a0       $t1                            # Moves the characters into
                              move      $a1       $t2
                              
                              jal       compare_chars
                              
                              addi      $t3       $t3       1
                              addi      $t4       $t4       1
                              
                              j         comcha
                              
                              next:     nop
                              
                                        beqz      $t2       exitcomcha
                                        nop
                                        
                                        j         setZero
                              
                    exitcomcha:         nop               
                                        li        $v0       1
                                        j         done
                                        
                    setZero:  nop   
                              li        $v0        0
                              
                    done:     nop
                    
                    lw        $ra       ($sp)
                    addi      $sp       $sp       4
                    jr        $ra

#--------------------------------------------------------------------
# compare_chars
#
# input: $a0 - first char to compare (contained in the least significant byte)
# $a1 - second char to compare (contained in the least significant byte)
#
# output: $v0 - comparison result (1 == chars the same, 0 == chars not the same)
#
#--------------------------------------------------------------------
compare_chars:      nop
                   
                    li        $v0       0                   # Assume that the characters are not the same
                    
                    sub       $t1       $a1       $a0       # Finds the difference in the ASCII value
                    abs       $t1       $t1                 # Finds the absolute value of the difference
                    
                    beq       $t1       0x0       set_one   # Sets the $v0 to 1 if the difference is 0(same char)
                    nop
                    
                    j         comcha_done                   # If neither of the above conditions are met, go to comcha_done
                                      
                    set_one:  nop                           # Changes the $v0 to 1 when the conditions are true
                              li        $v0       1
                              
                    comcha_done:        nop
                    
                    jr        $ra
##############################################################################################################
.data
space_allocated: .space 100
#################################################################################################### End of code
