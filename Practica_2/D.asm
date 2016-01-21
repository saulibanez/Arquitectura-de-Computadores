.data
str:	.asciiz "\nLa suma de dos los dos numeros es: \n"
num1: .byte 5
num2: .byte 7
num3: .half 3
num4: .half 4
num5: .word 1
num6: .word 2
.text
main: 
	
	#Cargo dos numeros tipo byte
	
	lb $t1, num1	
	lb $t2, num2

	la $a0, str
	li $v0, 4
	syscall
	
	add $t5, $t1, $t2
	move $a0, $t5
	li $v0, 1
	syscall
	
	#Cargo dos numeros tipo half
	
	lh $t1, num3	
	lh $t2, num4

	la $a0, str
	li $v0, 4
	syscall
	
	add $t5, $t1, $t2
	move $a0, $t5
	li $v0, 1
	syscall
	
	#Cargo dos numeros tipo word
	
	lw $t1, num5	
	lw $t2, num6

	la $a0, str
	li $v0, 4
	syscall
	
	add $t5, $t1, $t2
	move $a0, $t5
	li $v0, 1
	syscall
