.data
str:	.asciiz "Es un palindromo \n"
fail: .asciiz "No es un palindromo \n"
buffer: .space 1024
.text
main: 
	li $v0, 8
	la $a0, buffer
	li $a1, 1024
	syscall
	move $s0, $a0
	move $s1, $s0
	
loop:
	lb $t1, ($s1)
	beq $t1, 10, operar
	la $s1, 1($s1) #Desplazo 1 byte la cadena
	b loop
	
	
incrementar:
	la $s0, 1($s0)	
	
operar:
	la $s1, -1($s1)
	bgt $s0, $s1, end #si s0 es mayor que s1
	lb $t0, ($s0)
	lb $t1, ($s1)
	beq $t0, $t1, incrementar
	b distinto
	
end:
	la $a0, str
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall

distinto:

	la $a0, fail
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall