.data
prompt_operacao: .asciiz "Escolha a operação (1 - Soma, 2 - Subtração, 3 - Multiplicação, 4 - Exponenciação): "
prompt_num1: .asciiz "Digite o primeiro número: "
prompt_num2: .asciiz "Digite o segundo número: "
result: .asciiz "Resultado: "
.text
    # Exibir mensagem de escolha da operação
    li $v0, 4
    la $a0, prompt_operacao
    syscall

    # Ler a opção de operação do usuário
    li $v0, 5
    syscall
    move $t1, $v0  # Salvar a escolha da operação em $t1

    # Operação de soma, subtração ou multiplicação
    beq $t1, 1, soma
    beq $t1, 2, subtracao
    beq $t1, 3, multiplicacao
    beq $t1, 4, exponenciacao
    slti $t0, $t1, 4
    beq $t0, 0, naoFazNada

soma:
    # Exibir mensagem para digitar o primeiro número
    li $v0, 4
    la $a0, prompt_num1
    syscall

    # Ler o primeiro número
    li $v0, 5
    syscall
    move $t0, $v0  # Salvar o primeiro número em $t0

    # Exibir mensagem para digitar o segundo número
    li $v0, 4
    la $a0, prompt_num2
    syscall

    # Ler o segundo número
    li $v0, 5
    syscall
    add $t2, $t0, $v0  # Soma: t0 = t0 + v0
    j imprimir_resultado

subtracao:
    # Exibir mensagem para digitar o primeiro número
    li $v0, 4
    la $a0, prompt_num1
    syscall

    # Ler o primeiro número
    li $v0, 5
    syscall
    move $t0, $v0  # Salvar o primeiro número em $t0

    # Exibir mensagem para digitar o segundo número
    li $v0, 4
    la $a0, prompt_num2
    syscall

    # Ler o segundo número
    li $v0, 5
    syscall
    sub $t2, $t0, $v0  # Subtração: t0 = t0 - v0
    j imprimir_resultado

multiplicacao:
# Exibir mensagem para digitar o primeiro número
    li $v0, 4
    la $a0, prompt_num1
    syscall

    # Ler o primeiro número
    li $v0, 5
    syscall
    move $t0, $v0  # Salvar o primeiro número em $t0

    # Exibir mensagem para digitar o segundo número
    li $v0, 4
    la $a0, prompt_num2
    syscall

    # Ler o segundo número
    li $v0, 5
    syscall
    move $t1, $v0  # Salvar o segundo número em $t1

    # Inicializar o resultado da multiplicação (0)
    li $t2, 0

    # Multiplicação usando somas sucessivas
loop_multiplicacao:
    add $t2, $t2, $t0  # Adiciona o primeiro número ao resultado
    addi $t1, $t1, -1  # Decrementa o segundo número
    bne $t1, 0, loop_multiplicacao  # Salta de volta se o segundo número não for zero
    j imprimir_resultado
exponenciacao:
    # Exibir mensagem para digitar a base
    li $v0, 4
    la $a0, prompt_num1
    syscall

    # Ler a base
    li $v0, 5
    syscall
   
    add $t8, $zero, $v0
    move $t0, $v0  # Salvar a base em $t0

    # Exibir mensagem para digitar o expoente
    li $v0, 4
    la $a0, prompt_num2
    syscall

    # Ler o expoente
    li $v0, 5
    syscall
    add $t5, $zero, $v0
    move $t1, $v0  # Salvar o expoente em $t1
    # Inicializar o resultado da exponenciação (1)
   add $t2, $zero, $zero

calcula_exponenciacao:
    beq $t5, 1, resultado # Pular para o cálculo se o expoente não for zero
    add $t9, $zero, $t8

    jal multt
    
    move $t8, $t9			#de acordo com o numero da base
    add $t0, $zero, $t2
    add $t2, $zero, $zero
    j calcula_exponenciacao  # Loop para o próximo cálculo
multt:
    add $t2, $t2, $t0  # Adiciona o primeiro número ao resultado
    addi $t8, $t8, -1  # Decrementa o segundo número
    bne $t8, 0 , multt  # Salta de volta se o segundo número não for zero
    move $t8, $t9
    addi $t5, $t5, -1  # Decrementa o expoente meu limitador é a minha base, pois meu algoritmo faz somas sucessivas
    jr $ra
resultado:
	move $t2, $t0
	j imprimir_resultado
imprimir_resultado:
    # Exibir o resultado
    
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 10  # Encerrar o programa
    syscall
naoFazNada:
    li $v0, 10  # Encerrar o programa
    syscall