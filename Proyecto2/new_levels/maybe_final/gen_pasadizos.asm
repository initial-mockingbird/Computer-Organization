	gen_pasadizos:
	
	# prologo
	sw $fp ($sp)
	sw $ra -4($sp)
	move $fp $sp
	addiu $sp $sp -8


	li $v0 42
	li $a1 7
	syscall
	move $s0 $a0 # choosing how many walls we will generate.

	loop_pasadizo_making:
	beqz $s0 end_pasadizo
	li $v0 42
	li $a1 2
	syscall			# in which wall will it be generated?
	
	
	
	beqz $a0 v_wall			# in the space of vertical walls
	nop
	
	retry_h_wall:
	li $v0 42
	lw $a1 M
	addi $a1 $a1 -3
	syscall						# we choose a column to open a new tunnel.
	addi $a0 $a0 1
	move $s1 $a0
	
	lw $a0 map
	li $a1 0
	move $a2 $s1
	jal matriz_obtener
	beqz $v0 retry_h_wall	# if the path was already opened try again.
	
	lw $a0 map
	li $a1 0
	move $a2 $s1
	li $a3 0
	jal matrix_insert			# we insert the initial path in the matrix.
	
	lw $a0 map
	lw $a1 N
	addi $a1 $a1 -1
	move $a2 $s1
	li $a3 0
	jal matrix_insert			# we insert the final path in the matrix.
	
	li $a0 0
	move $a1 $s1
	li $a2 0
	jal display					# displaying the initial path on the screen.
	
	lw $a0 N
	addi $a0 $a0 -1
	move $a1 $s1
	li $a2 0
	jal display					# displaying the final path on the screen
	
	j next_pasadizo
	nop
	
	v_wall:
	
	retry_v_wall:
	li $v0 42
	lw $a1 N
	addi $a1 $a1 -3
	syscall						# we choose a column to open a new tunnel.
	addi $a0 $a0 1
	move $s1 $a0
	
	lw $a0 map
	move $a1 $s1
	li $a2 0
	jal matriz_obtener
	beqz $v0 retry_v_wall	# if the path was already opened try again.
	
	lw $a0 map
	move $a1 $s1
	li $a2 0
	li $a3 0
	jal matrix_insert			# we insert the initial path in the matrix.
	
	lw $a0 map
	move $a1 $s1
	lw $a2 M
	addi $a2 $a2 -1
	li $a3 0
	jal matrix_insert			# we insert the final path in the matrix.
	
	move $a0 $s1
	li $a1 0
	li $a2 0
	jal display					# displaying the initial path on the screen.
	
	move $a0 $s1
	lw $a1 M
	addi $a1 $a1 -1
	li $a2 0
	jal display					# displaying the final path on the screen
	
	next_pasadizo:
	addi $s0 $s0 -1
	j loop_pasadizo_making
	nop
	
	
	end_pasadizo:
	# epilogo
	addiu $sp $sp 8
	lw $fp ($sp)
	lw $ra -4($sp)
	jr $ra
	
	