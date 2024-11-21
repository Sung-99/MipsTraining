# Laboratório de Arquitetura e Organização de Computadores I
# Aluno: Vitor Hugo Mota
# Prof.ª Poliana Corrêa 
#Tarefa02

.data
Menu: .asciiz "==================MENU==================\n*Opção questão A(Dig 1)*\n*Opção questão B(Dig 2)*\n*Opção questão C(Dig 3)*\n*Opção questão D(Dig 4)*\n"
Parametro1MSG: .asciiz "Digite o primeiro numero: "
Parametro2MSG: .asciiz "Digite o segundo numero: "
Parametro3MSG: .asciiz "Digite o terceiro numero: "
DigiteSuaEscolha: .asciiz "Digite um numero que corresponda ao menu: "
espaco: .asciiz " "
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
	la $a0, Parametro1MSG       #Carrego a msg primeiro parametro
	li $v0, 4 		 #Direciono o sistema para exibir
	syscall	
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $a1, $v0		 #movo ela para a1
	jal Op3
	j finish
Op4Procedimento: 
	la $a0, Parametro1MSG       #Carrego a msg primeiro parametro
	li $v0, 4 		 #Direciono o sistema para exibir
	syscall	
	li $v0, 5		#Lendo primeira entrada de parametro
	syscall
	move $a1, $v0
	beq $a1, 1, finishNtermos1
	beq $a1, 0, finishNtermos1
	addi $t2, $zero, 1 #contador
	addi $a0, $zero, 1 #inicio
	li $v0, 1
	syscall
	la $a0, espaco #espacinho entre cada numero
	li $v0, 4
	syscall
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
	beq $a1, $a2, ConfereIguais #se os 2 primeiros sao iguais, pula para conferir os 2 ultimos 
	slt $t0, $a2, $a1 #Confiro os 2 primeiros
	beq $t0, 0, Ordena
	jal OrdenaComplexa
	beq $a1, $a2, finishOrd #se os 2 primeiros sao iguais tambem, nao se faz nada
	slt $t0, $a1, $a2 #Confiro os 2 primeiros após a analise do "fluxo mais chatinho"
	beq $t0, 0, finishOrd
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
	beq $a2, $a3, finishOrd #se os 2 ultimos sao iguais tambem, nao se faz nada e ja finaliza      
	slt $t0, $a3, $a2 #Confiro os 2 ultimos e se meu ultimo é maior que meu segundo numero, ele é maior que o primeiro tambem
	beq $t0, 1, finishOrd
	move $t1, $a2
	move $a2, $a3
	move $a3, $t1
	jr $ra #caso caia no fluxo mais chatinho, preciso conferir se meu segundo numero é menor que meu primeiro novamente
ConfereIguais: #caso os 2 ultimos sejam diferentes, basta saber se meu ultimo numero é maior 
		#que um dos dois primeiros, se sim, ele é colocado em primeiro
	beq $a2, $a3, finishOrd #se os 2 ultimos sao iguais tambem, nao se faz nada e ja finaliza    
	slt $t0, $a3, $a2
	beq $t0, 0, MudaElemento #avalia se o ultimo é maior que o penultimo, se sim, troca posição
	j finishOrd #se meu ultimo é menor que meu segundo(que é igual ao primeiro, deixa do jeito que está)
MudaElemento:
	move $t1, $a1
	move $a1, $a3
	move $a3, $t1
	j finishOrd #finaliza após a ultima análise
# ===================== FIM DE TUDO SOBRE A OPÇÃO 2=========================================
# ===================== TUDO SOBRE A OPÇÃO 3 ================================================
Op3:#reutilizei um exercicio ja feito em outra tarefa
	addi $t0, $zero, 1 
	add $a2, $a1, $zero
	loop:	
		add $a2, $a2, $a3
		sub $a3, $a1, $t0
	
		slti $t1, $a3, 1
		addi $t0, $t0, 1	
		beq $t1,$zero, loop	
	exit:
		add $a0, $a2, $zero
		li $v0, 1
		syscall
	jr  $ra
# ===================== FIM DE TUDO SOBRE A OPÇÃO 3========================================
# ===================== TUDO SOBRE A OPÇÃO 4 ===============================================
Op4:#reutilizei um exercicio ja feito em outra tarefa
    #caso em que o usuario digitou algo diferente de 1 ou 0
	sub $a1, $a1, 1 
	beq $a1, $zero, sair
	
	add $t2, $t2, 1
	and $t3, $t2, 1
	beq $t3, 1, eImpar
	beq $t3, 0, mostrar
    
mostrar:
	add $a0, $t2, $zero
	li $v0, 1
	syscall
	la $a0, espaco
	li $v0, 4
	syscall
	j Op4

eImpar:	
	add $t2, $t2, 1
	j mostrar
sair: #fim do algoritmo
	jr  $ra
# ===================== FIM DE TUDO SOBRE A OPÇÃO 4 =======================================


#fim de tudo
finishOrd: #um finish diferente, pois foi pedido na questao que mostrasse os numeros ordenados
	move $a0, $a1
	li $v0, 1
	syscall
	move $a0, $a2
	li $v0, 1
	syscall
	move $a0, $a3
	li $v0, 1
	syscall
	li $v0, 10
	syscall
finishNtermos1:#um finish diferente, pois foi pedido na questao que mostrasse os n termos quando digita 1 ou 0
	move $a0, $a1
	li $v0, 1
	syscall
	li $v0, 10
	syscall	 		
finish:
	li $v0, 10
	syscall	
	
	