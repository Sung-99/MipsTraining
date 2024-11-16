.data
Menu: .asciiz "==================MENU==================\n*Opção questão A(Dig 1)*\n*Opção questão B(Dig 2)*\n*Opção questão C(Dig 3)*\n*Opção questão D(Dig 4)*\n"
Parametro1MSG: .asciiz "Digite o primeiro numero: "
Parametro2MSG: .asciiz "Digite o segundo numero: "
Parametro3MSG: .asciiz "Digite o terceiro numero: "
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

# ===================== QUESTAO A ================================================
Op1Procedimento:
# ===================== PARAMETROS PARA A OPÇÃO 1 (LEVA COMO PARAMETRO (a1 e a2) PARA DENTRO DO JAL(FUNÇÃO))================================================	
	la $a0, Parametro1MSG       #Carrego a msg primeiro parametro
	li $v0, 4 		 #Direciono o sistema para exibir
	syscall			 
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $a1, $v0		 #movo ela para a1
	la $a0, Parametro2MSG	 #Carrego a msg segundo parametro
	li $v0, 4		 #Direciono o sistema para exibir
	syscall
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $a2, $v0		#movo ela para a2
	#CHAMAR FUNÇÃO OP1(MAIOR OU MENOR NUMERO)
	jal Op1
	#retorno da função
	j finish
# ===================== QUESTAO B ================================================
Op2Procedimento:
# ===================== PARAMETROS PARA A OPÇÃO 2 (LEVA COMO PARAMETRO (a1, a2 e a3 ) PARA DENTRO DO JAL(FUNÇÃO))================================================	

	la $a0, Parametro1MSG       #Carrego a msg primeiro parametro
	li $v0, 4 		 #Direciono o sistema para exibir
	syscall			 
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $a1, $v0		 #movo ela para a1
	la $a0, Parametro2MSG	 #Carrego a msg segundo parametro
	li $v0, 4		 #Direciono o sistema para exibir
	syscall
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $a2, $v0		#movo ela para a2
	la $a0, Parametro3MSG	 #Carrego a msg segundo parametro
	li $v0, 4		 #Direciono o sistema para exibir
	syscall
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $a3, $v0		#movo ela para a2
	#CHAMAR FUNÇÃO OP2(ORDENAÇÃO)
	jal Op2
	#retorno da função
	j finish
Op3Procedimento: 
	jal Op3
	j finish
Op4Procedimento: 
	jal Op4
	j finish	


# ===================== TUDO SOBRE A OPÇÃO 1 ================================================
Op1: # --------------------- Opção 1 --------------------------
	slt $t3, $a1, $a2	#confiro qual é o maior numero
	beq $t3, $zero, MaiorPrimeiro	#se for a0, mando para label referente ao a0 ser o maior
	j MaiorSegundo
MaiorPrimeiro:# Maior numero sedo o primeiro digitado logo na subtração será a1 - a2
	sub $t4, $a1, $a2
	
	slt $t0, $a1, $t4
	beq $t0, $zero Retorna1 #Após o calculo da subtração preciso exibir 1 caso o primeiro digitado seja maior que a subtração de a1 - a2
	j Retorna0 #Caso contrario, primeiro digitado seja menor que a1 - a2
MaiorSegundo:	# Maior numero sedo o segundo digitado logo na subtração será a2 - a1
	sub $t4, $a2, $a1
	slt $t0, $a1, $t4
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
	slt $t0, $a2, $a1 #Confiro os 2 primeiros
	beq $t0, 1, Ordena
	jal OrdenaComplexa
	slt $t0, $a1, $a2 #Confiro os 2 primeiros após a analise do "fluxo mais chatinho"
	beq $t0, 1, finish
Ordena: #após o retorno, meu a1 será menor que meu a2, entao preciso saber se meu menor numero é menor que o terceiro
	move $t1, $a1
	move $a1, $a2
	move $a2, $t1
	j Op2 #volto a fazer a conferencia indo para o fluxo inicial(obviamente vai passar do meu primeiro beq q confere os 2 primeiros numeros)
	#resumidamente eu coloco meu menor numero (a2) em um auxiliar, depois coloco meu maior numero a1 em a2 e volto com meu auxiliar que está com meu menor numero para a1
OrdenaComplexa:
	      #essa ordenação mexe com o caso em que meu numero está em ultimo e o numero do meio ja é maior que o primeiro
	      #por exemplo, ordenação simples : 5 1 3, eu simplesmente ando com o 5 até a ultima posição, isso segue o fluxo normal do código
	      #	fluxo onde a2 < a1 ====*(após a troca)* a2 < a3 ===== fim
	      #fluxo mais chatinho a1 < a2 > a3 ou a1 > a2 > a3 aonde meu primeiro beq será pulado 
	      
	slt $t0, $a3, $a2 #Confiro os 2 ultimos e se meu ultimo é maior que meu segundo numero, ele é maior que o primeiro tambem
	beq $t0, 0, finish
	move $t1, $a2
	move $a2, $a3
	move $a3, $t1
	jr $ra #caso caia no fluxo mais chatinho, preciso conferir se meu segundo numero é menor que meu primeiro novamente
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
	
	
