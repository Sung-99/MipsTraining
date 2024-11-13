# Laboratório de Arquitetura e Organização de Computadores I
# Prof.ª Poliana Corrêa 
# Esse programa imprime na tela a mensagem de msg 
# pelo número de vezes informado pelo usuário

.data
input: .asciiz "Type a number:"


.text
addi $v0, $zero, 4
la $a0, input			
syscall 
addi $v0, $zero, 5		
syscall
add $s0, $zero, $v0		
addi $t0, $zero, 1
add $s2, $s0, $zero
loop:	
	 

	
	add $s2, $s2, $s1
	sub $s1, $s0, $t0
	
	slti $t1, $s1, 1
	addi $t0, $t0, 1	
	beq $t1,$zero, loop	
exit:
	move $a0, $s2
	li $v0, 1
	syscall
	
	
