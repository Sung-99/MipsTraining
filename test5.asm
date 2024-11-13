.data
v1: .word 0:5
.text

li $v0, 5
la $t1, v1
syscall
sw $v0, 0($t1)
lw $t2, 0($t1)
addi $t2, $t2, 4
sw $t2, 0($t1)
lw $a0, 0($t1)
addi $t1, $t1, 4
li $v0, 1
syscall
li $v0, 10
syscall

