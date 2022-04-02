.data
	x:		.float		0,0, 0,0, 0,0, 0,0
	y:		.float		1.1, 2.2, 3.3, 4.4
	z:		.float		0.12, 0.23, 0.34, 0.45

.text

mm:		
	#a0 <--- &x
	#a1 <--- &y
	#a2 <--- &z

	li $t0, 0	# $t0 <-- i
	li $t1, 0	# $t1 <-- j
	li $t2, 0	# $t2 <-- k

	loopi:
		slti $t3, $t0, 2
		beqz $t3, idone
				
		loopj:
			slti $t3, $t1, 2
			beqz $t3, idone
					
			loopk:
					
				slti $t3, $t2, 2
				beqz $t3, kdone
				
				#setup x[][]
				add $s0, $a0, $t0   #x[][j]
				add $s0, $s0, $t1	#x[i][j]
				
				#setup y[][]
				add $s1, $a1, $t2	#y[][k]
				add $s1, $s1, $t0   #y[i][k]
				
				lwc1 $f2, 0($s1)	#$f2 <-- y[i][k]
					
				#setup z[][]
				add $s2, $a2, $t1	#z[][j]
				add $t2, $t2, $t2	#z[k][j]
				
				lwc1 $f4, 0($s2)	#f4 <-- z[k][j]
				
				#preform FP operation
				mul.d $f6, $f4, $f2 
				swc1 $f6, 0($s0)	# x[i][j] <-- y[i][k] * z[k][j]
				
				sw  $s0, 0($a0)		# store back into memory
					
				jloopk
				kdone:
			
			addi $t1, $t1, 1
			jloopj
			jdone:

		addi $t0, $t0, 1
		jloopi
		idone:

	jr $ra

main:
	
	#declare some floating point arrays
	la $a0, x
	la $a1, y
	la $a2, z
	
	jal mm

	li $v0, 10
	syscall



