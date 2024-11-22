# Laboratório de Arquitetura e Organização de Computadores I
# Aluno: Vitor Hugo Mota
# Prof.ª Poliana Corrêa 
#Tarefa04
.data
RetorneMaiorValor: .asciiz "O maior valor é: "
N: .asciiz "Quantos numeros você deseja ?" 
V: .word 0:10
#esp: .asciiz " " #quando estava debugando meu vetor pra ver se aparecia
.text
la $s1, V
addi $t1, $t1, 0
li $v0, 5
syscall
move $t7, $v0
j inserirNoVetor
inserirNoVetor:
	beq $t1, $t7, ChecaMaior
	li $v0, 5
	syscall
	sw $v0, 0($s1)
	addi $s1, $s1, 4
	addi $t1, $t1, 1
	j inserirNoVetor
ChecaMaior: #basicamente um procedimento que vai chamar minha função de recursao
	addi $t1, $zero, 0
	la $s1, V
	jal AlgoritmoAnalise
	j exit
AlgoritmoAnalise: #empilhar todas as posições até chegar na posição base(a ultima)
	addi $sp, $sp, -4
        sw $ra, 4($sp)
        addi $t1, $t1, 1	
	beq $t1, $t7, ArmazenaValorDaUltimaPosicao
	addi $s1, $s1, 4
	
	jal AlgoritmoAnalise
	lw $t6, 0($s1)
	slt $t0, $t6, $t5
	jal moveMaior
	j VoltaDesempilhando
ArmazenaValorDaUltimaPosicao: #caso base
	lw $t5, 0($s1)
	j VoltaDesempilhando
VoltaDesempilhando:
	lw $ra, 4($sp)
        addi $sp, $sp, 4
        addi $s1, $s1, -4
        jr $ra	
moveMaior: #caso encontre um valor maior que meu t5(q está armazenado em t5), ele vai ir pra permissaoconcedida e mover o novo valor para t5
	beq $t0, 0, permissaoconcedida
	jr $ra
permissaoconcedida:
	move $t5, $t6
	jr $ra
#Conferindo meus numberos(debug)
#exibir:
 #	beq $t2, 10, exit
  #  lw $a0, 0($s1)
   # addi $s1, $s1, 4               
    #li $v0, 1                   
    #syscall                    
    #li $v0, 4                   
    #la $a0, esp                 
    #syscall
    #add $t2, $t2, 1
    #j exibir
exit:
    li $v0, 4
    la $a0, RetorneMaiorValor
    syscall
    move $a0, $t5
    li $v0, 1	
    syscall
    li $v0, 10                  # Exit 
    syscall
#reinicia: do debug para exibir eu precisava reiniciar meu vetor
#	addi $t2, $t2, 0
#	la $s1, V
#	j exibir