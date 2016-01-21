.data
str:	.asciiz "\tHello Word!\n"
.text
main: 
	#Cojo la frase de str, la cargo en $a0, y para imrpimirlo por pantalla necesita la siguiente instruccion
	la $a0, str
	li $v0, 4
	syscall