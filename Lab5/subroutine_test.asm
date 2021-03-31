.data

.text

li        $a0       0x63
li        $a1       0x44

jal       compare_chars

move      $a0       $v0
li        $v0       1
syscall

end_program:        nop
                    li        $v0       10
                    syscall












.include  "Lab5.asm"
