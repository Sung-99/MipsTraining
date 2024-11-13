.data
Menu: .asciiz "==================MENU==================\n*Opção questão A(Dig 1)*\n*Opção questão B(Dig 2)*\n*Opção questão C(Dig 3)*\n*Opção questão D(Dig 4)*\n"
Parametro1: .asciiz "Digite o primeiro numero: "
Parametro2: .asciiz "Digite o primeiro numero: "
.text
la $a0, Menu
li $v0, 4
syscall
li $v0, 5
syscall
move $t0, $v0
jal Escolha
move $a0, $v0
li $v0, 1
syscall
li $v0, 10
syscall
Escolha:
	la $a0, Parametro1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	la $a0, Parametro2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a1, $v0
	slt $t0, $a0, $a1
	beq $t0, $zero Retorna1
	j Retorna0
Retorna1:
	addi $t1, $zero, 1
	move $v0, $t1
	jr  $ra
Retorna0:
	addi $t1, $zero, 0
	move $v0, $t1
	jr  $ra	