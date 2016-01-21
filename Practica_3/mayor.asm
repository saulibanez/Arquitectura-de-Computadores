.data
str:	.asciiz "Programa para comparar cual de dos numeros es mayor: \n"
introducir: .asciiz "introduce un numero: \n"
introducir2: .asciiz "introduce otro numero: \n"
num1: .word 0
num2: .word 0
frase: .asciiz "El mayor de los numeros es: \n"
.text
main: 

#Vamos a usar las instrucciones condicional (de salto), si va por un lado o por otro.
#branch -> rama/desvio, tambien hay otras instruccciones de salto, jump, pero de momento, usamos branch
#bgt -> saltas si es mayor que "n", tambien existira el blt (salta si es menor que "n")
#el pc(contador de programa va a variar)
#las instrucciones de salto se lo dice una etiqueta (a la izquierda), si la condicion no se satisface el contador de programa se incrementa en 4

	la $a0, str
	li $v0, 4
	syscall
	
	la $a0, introducir
	li $v0, 4
	syscall

#Introduzco por teclado un numero, y lo muevo a la direccion $t1
	li $v0, 5
	syscall
#Usando el move, usare los registros
#move $t1, $v0

#usando el store word guardo lo que tengo en el registro $t1 en la variable num1
	sw $v0, num1
	
	
	la $a0, introducir2
	li $v0, 4
	syscall
#Introduzco por teclado otro numero, y lo muevo a la direccion $t2
	li $v0, 5
	syscall
#move $t2, $v0
#usando el store word guardo lo que tengo en el registro $t2 en la variable num2
	sw $v0, num2
	
	
#cargo en registro los num1 y num2 que los tengo guardado en memoria
	lw $t3, num1
	lw $t4, num2
	
	la $a0, frase
	li $v0, 4
	syscall

	bgt $t3, $t4, mayor

menor:
	lw $a0, num2
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

mayor:
	lw $a0, num1
	li $v0, 1
	syscall

#Esta ultima línea la utilizo para finalizar el programa
	li $v0, 10
	syscall
	
	
	
	