# file1.asm
.data
msg2: .asciiz "\nmeu valor na pilha, mesmo após mudar meu valor fora dela:\n"
msg3: .asciiz "Meu  valor fora da pilha somado:"
.text
main:

    sub $sp, $sp, 4
    addi $t0, $zero, 10
    sw  $t0, 0($sp)
    add $t0, $t0, $t0	
    jal my_function    # Call my_function
    move $a0, $t0
    li $v0, 1
    syscall
    la $a0, msg2
    li $v0, 4
    syscall
    lw $t0, 0($sp)
    move $a0, $t0
    li $v0, 1	
    syscall
    addi $sp, $sp, 4
    # Exit the program
    li $v0, 10        # syscall for exit
    syscall

my_function:
    # Print a message from this function
    li $v0, 4         # syscall for print_string
    la $a0, msg3       # load address of the message
    syscall
   # add $sp, $sp, 4	
    jr $ra             # Return to the caller
