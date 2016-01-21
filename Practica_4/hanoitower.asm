	.data

	titulo: .asciiz "�Con cuantos discos quieres jugar? (1-8): "
	mover: .asciiz "\nMuevo el disco  "
	de: .asciiz " de la vara "
	a: .asciiz " a la "

	.text
	
main:

	la $a0, titulo
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0 #El primer parametro de jal sera el numero de discos
	#Designaremos las torres start finish y extra con 1 2 y 3 que seran los parametros de la función hanoi junto con el numero de discos
	li $a1, 1 
	li $a2, 2
	li $a3, 3 
	
	jal hanoi
	
	li $v0, 10
	syscall
	
hanoi:
	
	beqz $a0, fin_hanoi #cuando el número de discos sea cero terminara el hanoi
	#Crear pila
	subiu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 28	
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	sw $a2, -16($fp)
	sw $a3, -20($fp)
	
	#Resto para conseguir el n-1 y cargo en a2 y a3 los parametros que me piden (en el enunciado vienen que parametros necesito )
	addi $a0, $a0, -1
	lw $a2, -20($fp) #puedo usar un move
	lw $a3, -16($fp)
	jal hanoi# Irá llamando de forma recursiva a hanoi hasta completar todos los discos, posteriormente se iran imprimiendo todos los pasos
	
	#recuperamos los valores de la pila excepto a0, que lo vamos a modificar mientras imprimamos los pasos por pantalla
	
	lw $a1, -4($fp)
	lw $a2, -16($fp)
	lw $a3, -20($fp)

	#Imprimimos por pantalla los pasos
print:	  	
	la $a0, mover
	li $v0, 4
	syscall
	
	lw $a0, 0($fp)
	li $v0, 1
	syscall
	
	la $a0, de
	li $v0, 4
	syscall
	
	move $a0, $a1
	li $v0, 1
	syscall
	
	la $a0, a
	li $v0, 4
	syscall
	
	move $a0, $a2
	li $v0, 1
	syscall
	
	
	lw $a0 ,0($fp)
	subi $a0, $a0, 1
	lw $a1, -20($fp)
	lw $a3, -4($fp)
	jal hanoi #Volvemos a llamar recursivamente a hanoi como nos indica el código
	
	#Recuperamos la pila
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 32
	
fin_hanoi:
	jr $ra
