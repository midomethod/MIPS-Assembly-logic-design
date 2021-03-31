.data

.text

lw             $a0            ($sp)
li             $v0            34
syscall

addi           $t0            $zero          0xdeadbeef

subi           $sp            $sp            4
sw             $t0            ($sp)

lw             $a0            ($sp)
li             $v0            34
syscall   

exit:          nop
               li             $v0            10
               syscall      