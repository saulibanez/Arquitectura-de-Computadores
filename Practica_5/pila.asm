.data
	msg:  .asciiz  "introduce una cadena de números (0 o menor que 0 para terminar): " 
	result:  .asciiz  "La pila LIFO es: \n "
	jump: .asciiz "\n "
.text
main:
	#Escribiremos esto en primer lugar ya que como la sentencia imprimir funciona de manera recursiva,
	# podemos ensuciar el registro a0 con el mensaje
	la $a0, msg
	li $v0, 4
	syscall

	#Creamos el nodo raiz
	li $v0,5
	syscall
	
	blez $v0, end
	move $a0, $v0
	jal newnode
	
	move $a0, $v0
	move $t2, $a0
	
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
	
	#recuperamos la pila
	lw $a0,0($fp)
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	
endprint:
	jr $ra

newnode:
	move $t0, $a0
	li $a0, 12
	li $v0, 9
	syscall
	
	sw $t0, 0($v0)
	sw $zero, 4($v0)
	sw $zero, 8($v0)
	jr $ra
	
insert:
	subiu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 28
	
loop:
	lw $t0, 0($a1)
	lw $t1, 4($a1)			#si no es mayor, cargo en $t1 el valor
	blez $t1, void			#si es menor o igual a 0, lo vacio
	lw $a1, 4($a1)			#Si no es 0 hago que $a1 sea ahora el de la izquierda de antes y vuelvo a llamar a loop
	b loop

void:
	jal newnode		#como estaba vacio llamo a crearnodo
	sw $v0,4($a1)
	#recupero pila
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 32
	jr $ra
	
