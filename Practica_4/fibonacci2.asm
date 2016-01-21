.data
	msg: .asciiz "función de fibonacci:\n"
	num: .word 0
.text
main:
	#cargo la frase
	la $a0, msg
	li $v0, 4
	syscall	
	#introduzco el numero y lo guardo en la variable num y lo dejo en a0 por si lo tiene que llamar jal
	li $v0, 5
	syscall
	sw $v0, num
	move $a0, $v0
	jal fibonacci
	
	move $a0, $v0
	li $v0, 1
	syscall

end:
	li $v0, 10
	syscall

fibonacci:
	bgt $a0,1,recursive
	li $v0, 1
	jr $ra
	
recursive:	
	subu $sp, $sp, 32 	#Stack frame is  32 bytes long
	sw $ra, 20($sp)		#Save return address
	sw $fp, 16($sp)		#Save old frame pointer
	addiu $fp, $sp, 28	#Set up frame pointer
	sw $a0, 0($fp)		#Save argument (n)	

	subu $a0, $a0, 1	#Compute n-1
	jal fibonacci
	sw $v0, -4($fp)
	lw $a0, 0($fp)
	subi $a0, $a0, 2
	jal fibonacci
	lw $t1, -4($fp)
	add $v0, $v0, $t1
	
return:
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
