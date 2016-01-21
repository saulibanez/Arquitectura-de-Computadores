.data
str:	.asciiz "\nLa suma de dos los dos numeros es: \n"
t1: .space 2
t2: .space 4
.text
main: 
	
	#Introduzco por teclado un numero, y lo muevo a la direccion $t1
	li $v0, 5
	syscall
	move $t1, $v0
	sb $t1, t1 #store byte, store half, store word
	
	#Introduzco por teclado un numero, y lo muevo a la direccion $t2
	li $v0, 5
	syscall
	move $t2, $v0
	sb $t2, t2
	
	la $a0, str
	li $v0, 4
	syscall
	
	add $t5, $t1, $t2
	move $a0, $t5
	li $v0, 1
	syscall
