.data
str:	.asciiz "La suma de dos los dos numeros es: \n"
cadena:	.asciiz "Introduce un numero: \n"
.text
main: 
	#Cojo la frase de cadena, la cargo en $a0, y para imrpimirlo por pantalla necesita la siguiente instruccion
	la $a0, cadena
	li $v0, 4
	syscall
	
	#Introduzco por teclado un numero, y lo muevo a la direccion $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Cojo la frase de cadena, la cargo en $a0, y para imrpimirlo por pantalla necesita la siguiente instruccion
	la $a0, cadena
	li $v0, 4
	syscall
	
	#Introduzco por teclado otro numero, y lo muevo a la direccion $t2
	li $v0, 5
	syscall
	move $t2, $v0
	
	#Cojo la frase de str, la cargo en $a0, y para imrpimirlo por pantalla necesita la siguiente instruccion
	la $a0, str
	li $v0, 4
	syscall
	
	#Con add sumo los valores que tienen $t1 y $t2, y lo almaceno en $t5, lo muevo a $a0 y la siguiente instruccion se usa para poder imprimirlo por pantalla
	add $t5, $t1, $t2
	move $a0, $t5
	li $v0, 1
	syscall