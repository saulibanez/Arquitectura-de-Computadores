.data
	msg:  .asciiz  "introduce una cadena de números (0 o menor que 0 para terminar): " 
	result:  .asciiz  "El árbol ordenado de menor a mayor es: \n "
	jump: .asciiz "\n "

.text
	la $a0, msg
	li $v0, 4
	syscall
	
	#crear el nodo raiz
	li $v0, 5
	syscall
	
	blez $v0, end
	move $a0, $v0
	jal newnode
	
	move $a0, $v0
	move $t2, $a0	#muevo a $t2 la direccion del nodo raiz

readnumber:
	li $v0, 5
	syscall
	blez $v0, endread	#si es menor o igual a 0, termino la ejecucion
	move $a0, $v0
	move $a1, $t2
	jal insert
	b readnumber
	
endread:
	#cargo la frase
	la $a0, result
	li $v0, 4
	syscall
	
	move $a0,$t2	
	jal print
				
end:
	li $v0, 10
	syscall
	
print:
	blez $a0, endprint
	#creo pila
	subiu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 28
	
	sw $a0,0($fp) 
	lw $a0,4($a0) 	#cargo en a0 el valor de la izquierda del nodo y vuelvo a llamar a print
	jal print
	
	lw $a0,0($fp)	#cargo en a0 lo que tenía en la posicion 0 del fp
	lw $a0,0($a0)	#y lo que quiero son los primeros bytes de la posicion a0
	
	#imprimo el valor del nodo
	li $v0,1
	syscall
	
	#imprimo un /n
	la $a0, jump
	li $v0,4
	syscall
	
	lw $a0,0($fp)	#cargo en a0 lo que tenía en la posicion 0 del fp
	lw $a0,8($a0)	#cargo en a0 el valor de la derecha del nodo y vuelvo a llamar a print
	jal print
	
	#recuperamos la pila
	lw $a0,0($fp)
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	
endprint:
	jr $ra
	
newnode:
	move $t0, $a0
	li $a0, 12	#sbrk
	li $v0, 9	#sbrk
	syscall
	sw $t0, 0($v0)
	sw $zero, 4($v0)
	sw $zero, 8($v0)
	jr $ra

insert:
	#creo pila
	subiu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 28

loop:
	lw $t0, 0($a1)
	bgt $a0, $t0, insert_right	#si el valor de a0, es mayor que el de $t0, lo inserto en la derecha

insert_left:
	lw $t1, 4($a1)			#si no es mayor, cargo en $t1 el valor de la izquierda
	blez $t1, void_left		#si es menor o igual a 0, vacio la izquierda
	lw $a1, 4($a1)			#Si no es 0 hago que $a1 sea ahora el de la izquierda de antes y vuelvo a llamar a loop
	b loop

insert_right:
	lw $t1, 8($a1)
	blez $t1, void_right
	lw $a1, 8($a1)
	b loop

void_left:
	jal newnode		#como estaba vacio llamo a crearnodo
	sw $v0,4($a1)
	#recupero pila
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 32
	jr $ra
	
void_right:
	jal newnode		#como estaba vacio llamo a crearnodo
	sw $v0,8($a1)
	#recupero pila
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 32
	jr $ra
	