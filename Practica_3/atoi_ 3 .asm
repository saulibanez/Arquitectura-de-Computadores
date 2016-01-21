.data
str: .asciiz "atoi_2: \n"
fail: .asciiz "don't exist negative + letter \n"
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

	bgt $t1, 57, end
	ble $t1, 47, end
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
	bgt $t1, 57, terminate
	ble $t1, 47, terminate
	
loop:
	bgt $t1, 57, end
	ble $t1, 47, end
	addi $t3, $t1, -48
	la $s0, 1($s0)
	
	add $t3, $t3, $t5
	sw $t3, num
	lb $t1, ($s0)
	
	beq $t1, 10, end
	mul $t5, $t3, 10
	
	b loop
	
terminate:
	la $a0, fail
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall

end:
	lw $t3, num #cargo la variable num en $t3
	mul $t3, $t3, $s7 #multiplico por 1 o -1
	sw $t3, num #le asigno el valor que tiene $t3 a num
	
	lw $a0, num #cargo en $a0 lo que tiene num
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
