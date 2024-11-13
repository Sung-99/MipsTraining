.data
msg: .asciiz "Digite um numero: "
esp: .asciiz "\n"
vetorB: .word 0:16           # word de  16 inteiros 
vetorA: .word 0:8           # word de 8 inteiros
fim: .asciiz "\nfim !!!"

.text
main:
    # Step 1: carrego meu vetor para ler
    la $t0, vetorB          
    li $t1, 0                  # iterador

loopInput:
    # ler os numeros no vetor VetorB
    li $v0, 4                   
    la $a0, msg              
    syscall

    li $v0, 5                  
    syscall
    sw $v0, 0($t0)             
    addi $t1, $t1, 1           # incremento
    addi $t0, $t0, 4           # prox posição
    bne $t1, 16, loopInput     # repete ate o numero ser diferente de 16

    # Step 2: passar do vetor B para o vetor A
    la $t0, vetorB            # recarregar o vetor B na posicao 0
    la $t4, vetorA            # carregar o vetorA
    li $t2, 0                  # iterador para vetorA

alocandoEmA:
    lw $t5, 0($t0)             
    sw $t5, 0($t4)            
    addi $t2, $t2, 1         
    addi $t4, $t4, 4          
    addi $t0, $t0, 8           
    bne $t2, 8, alocandoEmA    

    # Step 3: multiplicação
    la $t4, vetorA            # recarrego A
    li $t9, 1                  # resultado da multiplicação
    li $t5, 0                  # contador externo

outer_interacao:
    slti $t3, $t5, 8
    beq $t3, 0, exibir         # se na contagem externa passar de 8 ele vai pra exibir

    lw $t6, 0($t4)             
    li $t7, 0            #contador interno     
    li $t8, 0                 

inner_iterecao:
    beq $t7, $t6, pula_num      # ´pula pro prox numero quando o numero atual é alcançado pelo contador interno
    add $t8, $t8, $t9           # Add the current result to accumulator
    addi $t7, $t7, 1            # Increment inner counter
    j inner_iterecao            # Repeat inner loop

pula_num:
    add $t9, $t8, $zero               # Update result
    addi $t4, $t4, 4            # Move to the next element in vetorA
    addi $t5, $t5, 1            # Increment outer counter
    j outer_interacao           # Repeat outer loop

exibir:
    # Display the result
    add $a0, $t9, $zero               # Move final result into $a0 for printing
    li $v0, 1                   # Print integer service
    syscall                     # Print the result

    # Print newline
    li $v0, 4                   # Print string service
    la $a0, esp                 # Load address of newline
    syscall

exit:
    li $v0, 4                   # Print string service
    la $a0, fim                 # Load end message
    syscall

    li $v0, 10                  # Exit service
    syscall