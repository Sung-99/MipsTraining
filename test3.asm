.data
msg: .asciiz "Digite o numeru (N) de termos:"
fim: .asciiz "\nFIM\n"
espaco: .asciiz " "
.text
main:
la $a0, msg
li $v0, 4
syscall
li $v0, 5
syscall
add $t1, $zero, $v0
beq $t1, 1, exit1  
beq $t1, $zero, exit
addi $t2, $zero, 1
li $a0, 1
li $v0, 1
syscall
la $a0, espaco
li $v0, 4
syscall
bne $t1, $zero, loop

loop:	#caso em que o usuario digitou algo diferente de 1 ou 0
	sub $t1, $t1, 1 
	beq $t1, $zero, exit
	
	add $t2, $t2, 1
	and $t3, $t2, 1
	beq $t3, 1, eImpar
	beq $t3, 0, mostrar
exit1:#caso em que o usuario só digitou o numero 1	
	li $a0, 1             
    	li $v0, 1
    	syscall             

exit:#Fim de tudo	
    li $v0, 4
    la $a0, fim
    syscall
    li $v0, 10
    syscall
    
mostrar:
	add $a0, $t2, $zero
	li $v0, 1
	syscall
	la $a0, espaco
	li $v0, 4
	syscall
	j loop

eImpar:	
	add $t2, $t2, 1
	j mostrar
#printf("digite um numero");
#scanf("$d",$d);



#while(d > 0){



#}
