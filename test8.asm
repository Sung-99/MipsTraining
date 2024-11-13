.data
Menu: .asciiz "==================MENU==================\n*Opção questão A(Dig 1)*\n*Opção questão B(Dig 2)*\n*Opção questão C(Dig 3)*\n*Opção questão D(Dig 4)*\n"
Parametro1MSG: .asciiz "Digite o primeiro numero: "
Parametro2MSG: .asciiz "Digite o primeiro numero: "
DigiteSuaEscolha: .asciiz "Digite um numero que corresponda ao menu: "
.text
la $a0, Menu
li $v0, 4
syscall
la $a0, DigiteSuaEscolha
li $v0, 4
syscall
li $v0, 5
syscall
move $t0, $v0
beq $t0, 1, Op1Procedimento   # Se ele digita 1, ira para uma label que vai encaminha-lo para o PROCEDIMENTO 1
beq $t0, 2, Op2Procedimento   # Se ele digita 2, ira para uma label que vai encaminha-lo para o PROCEDIMENTO 2
beq $t0, 3, Op3Procedimento   # Se ele digita 3, ira para uma label que vai encaminha-lo para o PROCEDIMENTO 3
beq $t0, 4, Op4Procedimento   # Se ele digita 4, ira para uma label que vai encaminha-lo para o PROCEDIMENTO 4
li $v0, 10
syscall #Alguma coisa alem das opções >>>>>>>>>>> diréto pro final

Op1Procedimento: 
	jal Op1
	j finish
Op2Procedimento: 
	jal Op2
	j finish
Op3Procedimento: 
	jal Op3
	j finish
Op4Procedimento: 
	jal Op4
	j finish	


# ===================== TUDO SOBRE A OPÇÃO 1 ================================================
Op1: # --------------------- Opção 1 --------------------------
	la $a0, Parametro1MSG       #Carrego a msg primeiro parametro
	li $v0, 4 		 #Direciono o sistema para exibir
	syscall			 
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $t1, $v0		 #movo ela para a0
	la $a0, Parametro2MSG	 #Carrego a msg segundo parametro
	li $v0, 4		 #Direciono o sistema para exibir
	syscall
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $t2, $v0		#movo ela para a0
	slt $t3, $t1, $t2	#confiro qual é o maior numero
	beq $t3, $zero, MaiorPrimeiro	#se for a0, mando para label referente ao a0 ser o maior
	j MaiorSegundo
MaiorPrimeiro:# Maior numero sedo o primeiro digitado logo na subtração será a0 - a1
	sub $t4, $t1, $t2
	
	slt $t0, $t1, $t4
	beq $t0, $zero Retorna1 #Após o calculo da subtração preciso exibir 1 caso o primeiro digitado seja maior que a subtração de a0 - a1
	j Retorna0 #Caso contrario, primeiro digitado seja menor que a0 - a1
MaiorSegundo:	# Maior numero sedo o segundo digitado logo na subtração será a1 - a0
	sub $t4, $t2, $t1
	slt $t0, $t1, $t4
	beq $t0, $zero Retorna1 #Após o calculo da subtração preciso exibir 1 caso o primeiro digitado seja maior que a subtração de a1 - a0
	j Retorna0 #Caso contrario, primeiro digitado seja menor que a1 - a0
Retorna1:
	la $a0, 1
	li $v0, 1
	syscall
	jr  $ra	#Chamo ra exibir o resultado
Retorna0:
	la $a0, 0
	li $v0, 1
	syscall
	jr  $ra		#Chamo ra exibir o resultado	

# ===================== FIM DE TUDO SOBRE A OPÇÃO 1 =========================================

# ===================== TUDO SOBRE A OPÇÃO 2 ================================================
Op2:
	addi $v0, $zero, 2
	jr  $ra
# ===================== FIM DE TUDO SOBRE A OPÇÃO 32=========================================
# ===================== TUDO SOBRE A OPÇÃO 3 ================================================
Op3:
	addi $v0, $zero, 3
	jr  $ra
# ===================== FIM DE TUDO SOBRE A OPÇÃO 3========================================
# ===================== TUDO SOBRE A OPÇÃO 4 ===============================================
Op4:
	addi $v0, $zero, 4
	jr  $ra
# ===================== FIM DE TUDO SOBRE A OPÇÃO 4 =======================================


#fim de tudo
finish:
li $v0, 10
syscall	
	
	
