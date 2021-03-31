.text
li $v0 8
la $a0 buffer
li $a1 100
syscall

li $v0 4
syscall

li $v0 10
syscall

.data
buffer: .space 100