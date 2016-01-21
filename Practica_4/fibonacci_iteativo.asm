.data
	msg: .asciiz "función de fibonacci:\n"
	num: .word 0
	n1: .word 0
	n2: .word 0
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
	lw $t0, num

	beq $v0, 0, sum1
	beq $v0, 1, sum1
	
	li $t1, 1
	li $t2, 1
	add $t6, $t2, $t1
salto:
	bgt $t2, $t1, mayor
	
menor:
	add $t2, $t2, $t1
	add $t6, $t6, 1
	ble $t0, $t6, sumfinal
	b salto
mayor:
	add $t1, $t2, $t1
	add $t6, $t6, 1
	ble $t0, $t6, sumfinal
	b salto

sumfinal:
	add $a0, $t1, $t2
	li $v0, 1
	syscall
	b end
	
sum1:
	li $a0, 1
	li $v0, 1
	syscall
end:
	li $v0, 10
	syscall	
