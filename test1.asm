.data 
msg: .asciiz "n1:"
msg2: .asciiz "n2:"
.text
li $v0, 4
la $a0, msg
syscall
li $v0, 5
syscall
add $t0, $v0, $zero
li $v0, 4
la $a0, msg2
syscall
li $v0, 5
syscall
add $a0, $v0, $t0
li $v0, 1
syscall
li $v0, 10
syscall