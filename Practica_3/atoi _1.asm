.data
str: .asciiz "atoi_1: \n"
buffer: .space 1024
num: .word 0
.text

	li $v0, 8
	la $a0, buffer
	li $a1, 1024
	syscall

	move $s0, $a0
	lb $t1, buffer
	#sw $t1, num#guarda el contenido de $t1 en num
	
	addi $t4, $t1, -48
	la $s0, 1($s0) #Desplazo 1 byte la cadena
	sw $t4, num
	lb $t1, ($s0)
	beq $t1, 10, end
	mul $t5, $t4, 10
	
loop:
	addi $t3, $t1, -48
	la $s0, 1($s0)
	
	add $t3, $t3, $t5
	sw $t3, num
	lb $t1, ($s0)
	
	beq $t1, 10, end
	mul $t5, $t3, 10
	
	b loop

end:
	lw $a0, num
	li $v0, 1
	syscall

	li $v0, 10
	syscall
