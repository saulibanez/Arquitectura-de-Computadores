		.data
msg:		.asciiz "the factorial of 10 is: "

		.text
main:	
	la $a0, msg
	li $v0, 4		#Load syscall print-string into $v0
	syscall			#Make the syscall
	
	li $a0, 10		#Put argument 10 in $a0
	jal fact		#Call factorial function
	
	move $a0, $v0		#Move fact result in $a0
	li $v0, 1		#Load syscall print-int into $v0
	syscall
	
	li $v0, 10		#load syscall exit into $v0
	syscall			
	
fact:
	subu $sp, $sp, 32 	#Stack frame is  32 bytes long
	sw $ra, 20($sp)		#Save return address
	sw $fp, 16($sp)		#Save old frame pointer
	addiu $fp, $sp, 28	#Set up frame pointer
	sw $a0, 0($fp)		#Save argument (n)
	
	lw $v0, 0($fp)
	bgtz $v0, fact_recurse	#fact(n-1)
	li $v0, 1
	b return
	
fact_recurse:
	lw $v1, 0($fp)		#Load n
	subu $v0, $v1, 1	#Compute n-1
	move $a0, $v0		#Move value to $a0
	jal fact
	
	lw $v1, 0($fp)		#Load n
	mul $v0, $v0, $v1	#Compute fact(n-1) *n
	
return:
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
