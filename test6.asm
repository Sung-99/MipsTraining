.data
opcaoInvalida: .asciiz "\nOpção Invalida!!!\n"
DigiteUmNumero: .asciiz "\nDigite um numero:"
default: .asciiz "Opção invalida"
Lookuptable:
	.word L0                  # Address for case 0
        .word L1                  # Address for case 1
    	.word L2                  # Address for case 2
    	.word L3                  # Address for case 3
soma: .asciiz "+"
igual: .asciiz "="
subtrac: .asciiz "-"
Divv: .asciiz "/"
Multt: .asciiz "*"
Primeiro: .asciiz "Primeiro: \n"
Depois: .asciiz "\nDepois: \n"
MeusValores: .asciiz "\n ===============Meus valores===================\n \n $s1 = 20(g) ---- $s2 = 4(h) ---- $s3 = 10(i) ---- $s4 = 6(j) \n"
.text
main:
##Apresentar valores
la $a0, MeusValores
li $v0, 4
syscall
#valores constantes das variaveis a serem somadas, subtraidas ou multiplicadas
la $a0, DigiteUmNumero
li $v0, 4
syscall
li $v0, 5 #Entrada do switch
syscall
li $s1, 20 #g
li $s2, 4 #h
li $s3, 10 #i
li $s4, 6 #j
li $t2, 4 #4 labels
add $t5, $v0, $zero

slt $t3, $t5, $zero # testa se k < 0
bne $t3, $zero, Default # se k < 0, desvia para Exit
slt $t3, $t5, $t2 # testa se k < 4
beq $t3, $zero, Default # se k >= 4, desvia para Exit
add $t1, $t5, $t5 # $t1 = 2*k
add $t1, $t1, $t1 # $t1 = 4*k
add $t1, $t1, $t4 # $t1 = endereço do table [k]
lw $t0, 0($t1) # $t0 = table[k]
jr $t0 # desvia com base em $t0
L0:
	li $t3, 0 #iterador
	add $s0, $s0, $s4
	addi $t3, $t3, 1
	beq $t3, $s3, somaResultado
	j L0
somaResultado:
	add $s7, $s7, $s1
	j Exit

L1:
	la $a0, Primeiro
	li $v0, 4
	syscall
	add $a0, $s1, $zero
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, soma
	syscall
	add $a0, $s2, $zero
	li $v0, 1
	syscall
	la $a0, igual
	li $v0, 4
	syscall
	add $a0, $s1, $s2
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, Depois
	syscall
	add $s0, $s1, $s2
	add $a0, $s0, $zero
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, soma
	syscall
	add $a0, $s3, $zero
	li $v0, 1
	syscall
	add $s0,$s0 , $s3
	add $a0, $s0, $zero
	la $a0, igual
	li $v0, 4
	syscall
	j Exit # fim do case, desvia para Exit
L2: 
	sub $s0, $s1 , $s2
	add $s0, $s0, $s4
	j Exit # fim do case, desvia para Exit
L3: 

	add $s7, $s3, $s1
	add $t6, $s4, $s2
	li $t3, 0 #quociente
IterarSubtracao:
	slt $t8, $s7, $t6
	bne $t8, $zero, Exit
	
	sub $s7, $s7, $t6
	
	addi $s0, $s0, 1
	
	j IterarSubtracao
	
Exit: # fim do comando switch
	add $a0, $s0, $zero
	li $v0, 1
	syscall
	li $v0, 10
	syscall
Default:
	la $a0, default
	li $v0, 4
	syscall
	li $v0, 10
	syscall	
