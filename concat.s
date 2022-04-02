.data
	str1:	.asciiz		"abcdefgh"
	space:	.space		124
	str2:	.asciiz		"ijklmnopqrstuvwxyz"
	nl:		.asciiz		"\n"
.text

main:	
	
	li $v0, 4
	la $a0, str2	#ptr to str1
	syscall
	la $a0, nl
	syscall

	la $a0, str1
	syscall
	la $a0, nl
	syscall

	la $a0, str1
	la $a1, str2	#ptr to str2
	li $s0, 0		#index counter	

	loop1:
		lbu $t0, 0($a0)
		beq $t0, $0, loop2
		addi $a0, $a0, 1
		j loop1

	#address in $a0 has '\0'
	loop2:
		lbu   $t0, 0($a1)		#load byte from concat arg	
		beq   $t0, $0, finish	#if the byte is the null byte we done
		sb    $t0, 0($a0)		#store 
		addi  $a0, $a0, 1		#increment by 1
		addi  $a1, $a1, 1		#increment by 1
		

		j loop2	
		
	finish:

		addi $a0, $a0, 1	#increment pointer to string one final time
		add  $t0, $0, $0	#prime a final null character
		sb   $t0, 0($a0)	#store final null byte

		la $a0, str1
		li $v0, 4
		syscall 

		li $v0, 10
		syscall


