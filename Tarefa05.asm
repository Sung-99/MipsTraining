# Aluno: Vitor Hugo Mota
# Prof.ª Poliana Corrêa 
#Tarefa05
# Laboratório de Arquitetura e Organização de Computadores I
# Aluno: Vitor Hugo Mota
# Prof.ª Poliana Corrêa 
#Tarefa05
.data
Imprimir: .asciiz "os valores em ordem decrescente sao: "
N: .asciiz "Quantos numeros você deseja ?" 
esp: .asciiz " " #quando estava debugando meu vetor pra ver se aparecia
.text
li $v0, 4
la $a0, N
syscall
li $v0, 5
syscall
move $a1, $v0
add $t0, $t0, $zero
j ordenarDecre

ordenarDecre:
	addi $sp, $sp, -4
    	sw $ra, 4($sp)
    	beq $t0, $a1, casoBase
    	
    	addi $t0, $t0, 1
    	jal ordenarDecre
    	move $a0, $a1
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, esp
	syscall
	beq $a1, 0, exit
	j fimFunc
casoBase:
	move $a0, $a1
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, esp
	syscall
fimFunc:
	 lw $ra, 4($sp)
    	 addi $sp, $sp, 4
    	 addi $a1, $a1, -1
    	 jr $ra
exit:
	li $v0, 10
	syscall