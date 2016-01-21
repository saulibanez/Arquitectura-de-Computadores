.data
	msg:  .asciiz  "introduce una cadena de números (0 para terminar): " 
	result:  .asciiz  "El árbol ordenado de menor a mayor es: \n "
	jump: .asciiz "\n "
.text
main:
	la $a0, msg
	li $v0, 4
	syscall

	#Creamos el nodo raiz
	li $v0,5
	syscall
	
	move $a0, $v0
	beqz $a0, iszero	#Si lo primero que metemos es un cero el programa termina
	jal newnode 

	move $a1,$v0 
	move $t2,$a1 	#muevo a $t2 la direccion del nodo raiz
	
readloop:
	li $v0,5
	syscall	
	beqz $v0, endreadloop
	move $a0, $v0 
	move $a1,$t2 
	jal insert 
	b readloop
	
endreadloop:
	la $a0, result
	li $v0, 4
	syscall 
		
	move $a0,$t2
		
	jal print
	#terminamos el programa
	li $v0,10
	syscall	
	
newnode: 
	move $t0,$a0	
	li $a0,12	#Reservamos 12 bytes (4 para cada campo del nodo)
	li $v0,9 	#me devuleve en v0 la direccion de memoria de los 12 bytes reservados (sbrk)
	syscall
	sw $t0,0($v0)
	jr $ra
	
insert:
	beqz $a1,iszero	#Antes de nada comprobamos si es 0, si no es cero reservamos pila
	subu $sp,$sp,32 
	sw $ra,4($sp)
	sw $fp,0($sp)
	addiu $fp,$sp,8
	
loop:
	lw $t0,0($a1)	
	bgt $a0,$t0,insertdecha 	#si a0 es mayor que t0 inserto a la derecha sino a la izquierda
	lw $t1,4($a1) 		#cargo en t1 el valor  izquierda
	beqz $t1,voidleft	#Si es igual a 0, vacio la izquierda
	lw $a1,4($a1)		#Si no es 0 hago que $a1 sea ahora el de la izquierda de antes y vuelvo a llamar a loop
	b loop

iszero:	
	li $v0,10
	syscall

insertdecha:
	lw $t1,8($a1) 
	beqz $t1,voidright  
	lw $a1,8($a1)	#Si no es 0 hago que $a1 sea ahora el de la derecha de antes y vuelvo a llamar a loop
	b loop

voidright:
	jal newnode 	#como estaba vacio llamo a crearnodo y recupero la pila
	sw $v0,8($a1) 
	lw $ra,4($sp)
	lw $fp,0($sp)
	addiu $sp,$sp,32
	jr $ra

voidleft:
	jal newnode #como estaba vacio llamo a crearnodo y recuopero la pila
	sw $v0,4($a1) 
	lw $ra,4($sp)	
	lw $fp,0($sp)
	addiu $sp,$sp,32
	jr $ra

print:
	beqz $a0,end #Antes de nada compruebo que no sea 0 cuando es 0 que vuelva a donde estaba antes
	#Creo pila
	subu $sp,$sp,32 	
	sw $ra,4($sp)
	sw $fp,0($sp)
	addiu $fp,$sp,8
	
	sw $a0,0($fp) 
	lw $a0,4($a0) 	#cargo en a0 el valor de la izquierda del nodo y vuelvo a llamar a print
	jal print
	
	lw $a0,0($fp)	#cargo en a0 lo que tenía en la posicion 0 del fp
	lw $a0,0($a0)	#y lo que quiero son los primeros bytes de la posicion a0
	li $v0,1 	#imprimo el valor del nodo
	syscall
	
	la $a0, jump	#imprimo un /n
	li $v0,4
	syscall
	
	lw $a0,0($fp)	#cargo en a0 lo que tenía en la posicion 0 del fp
	lw $a0,8($a0)	#cargo en a0 el valor de la derecha del nodo y vuelvo a llamar a print
	jal print 
	
	#recuperamos la pila
	lw $a0,0($fp)
	lw $ra,4($sp)
	lw $fp,0($sp)
	addiu $sp,$sp,32

end:
	jr $ra
