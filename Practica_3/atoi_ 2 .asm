.data
str: .asciiz "atoi_2: \n"
buffer: .space 1024
num: .word 0
.text
main:
	li $v0, 8
	la $a0, buffer
	li $a1, 1024
	syscall
	
	move $s0, $a0
	lb $t1, buffer
	sw $t1, num
	
	beq $t1, 45, savenegative
	li $s7, 1
	addi $t4, $t1, -48
	la $s0, 1($s0) #Desplazo 1 byte la cadena
	sw $t4, num
	lb $t1, 0($s0)
	beq $t1, 10, end
	mul $t5, $t4, 10
	b loop

savenegative:
	li $s7, -1
	la $s0, 1($s0) #Desplazo 1 byte la cadena
	lb $t1, 0($s0) #cargo la cadena en $t1
	
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
	lw $t3, num
	mul $t3, $t3, $s7 #multiplico por 1 o -1
	sw $t3, num #le asigno el valor que tiene $t3 a num
	
	lw $a0, num #cargo en $a0 lo que tiene num
	li $v0, 1
	syscall

	li $v0, 10
	syscall
