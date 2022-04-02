#this is for the C function:
#   void toUpperCase(char* str){
#
#	}
#
.data
	str:   .asciiz	"this is A trest Stre$aing"
.text


toUpper:
	addi $sp, $sp, -4
	sw	 $a0, 0($sp)

	loop:
		lb	$t0, 0($a0)
		beq $t0, $0, done
		addi $t0, $t0, -97
		bltz $t0, next
		slti $t1, $t0, 26
		beq  $t1, $0, next

		addi $t0, $t0, 65

		sb $t0, 0($a0)

		next:
			addi $a0, $a0, 1
			j loop
	
	done:
		lw   $a0, 0($sp)
		addi $sp, $sp, 4

		j $ra


main:
	

	la $a0, str
	li $v0, 4
	syscall
	jal toUpper
	la $a0, str
	li $v0, 4
	syscall

	li $v0, 10
	syscall
	
