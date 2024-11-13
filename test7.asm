.data
opcaoInvalida: .asciiz "\nOpção Invalida!!!\n"
	Lookuptable:
	.word L0                  # Address for case 0
        .word L1                  # Address for case 1
    	.word L2                  # Address for case 2
    	.word L3                  # Address for case 3
.text
li $s5, 1
li $t2, 4
li $s1, 3 #g
li $s2, 4 #h
li $s3, 5 #i
li $s4, 6 #j
la $t4, Lookuptable
slt $t3, $s5, $zero # testa se k < 0
bne $t3, $zero, Exit # se k < 0, desvia para Exit
slt $t3, $s5, $t2 # testa se k < 4
beq $t3, $zero, Exit # se k >= 4, desvia para Exit
add $t1, $s5, $s5 # $t1 = 2*k
add $t1, $t1, $t1 # $t1 = 4*k
add $t1, $t1, $t4 # $t1 = endereço do table [k]
lw $t0, 0($t1) # $t0 = table[k]
jr $t0 # desvia com base em $t0



L0: add $s0, $s3, $s4 # k=0, f = i + j
j Exit # fim do case, desvia para Exit
L1: add $s0, $s1, $s2 # k=1, f = g + h
j Exit # fim do case, desvia para Exit
L2: sub $s0, $s1, $s2 # k=2, f = g - h
j Exit # fim do case, desvia para Exit
L3: sub $s0, $s3, $s4 # k=3, f = i - j
Exit: # fim do comando switch
	add $a0, $s0, $zero
	li $v0, 1
	syscall
	li $v0, 10
	syscall