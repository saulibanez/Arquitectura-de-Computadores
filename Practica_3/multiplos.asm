.data
str:	.asciiz "Programa para calcular los multiplos de dos numeros: \n"
introducir: .asciiz "introduce un numero: \n"
introducir2: .asciiz "introduce otro numero: \n"
intro: .asciiz "\n"
resultado: .asciiz "El resultado es:\n"
num1: .word 0
num2: .word 0
frase: .asciiz "El mayor de los numeros es: \n"
.text
main: 

	la $a0, str
	li $v0, 4
	syscall
	
	la $a0, introducir
	li $v0, 4
	syscall
	
#Introduzco por teclado un numero, y lo muevo a la direccion $t1
	li $v0, 5
	syscall
#usando el store word guardo lo que tengo en el registro $t1 en la variable num1
	sw $v0, num1
	
	la $a0, introducir2
	li $v0, 4
	syscall
#Introduzco por teclado otro numero, y lo muevo a la direccion $t2
	li $v0, 5
	syscall
#usando el store word guardo lo que tengo en el registro $t2 en la variable num2
	sw $v0, num2
	lw $t1, num1
	lw $t2, num2
	li $t5, 0
	
	la $a0, resultado
	li $v0, 4
	syscall
loop:	
	beq $t2, $t5, end
	mul $t3, $t1, $t5
	move $a0, $t3
#para imprimir por pantalla
	li $v0, 1
	syscall
	la $a0, intro
	li $v0, 4
	syscall
	addi $t5, $t5, 1
	b loop
	
	
end:
	mul $t3, $t1, $t2
	move $a0, $t3
#para imprimir por pantalla
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	