## --- Plan inicio --- ##
#
# In params:
#	$a0: Game DIFFICULTY <NOT IMPLEMENTED>
#	
# Out params: <NONE>
#	DEVOLVER DIRECCION HEADER SOBRETODO
#
# Method vars: <NONE>
#
# Side Effects: 
#	A game is initialized.
#
# Example:
#
## --- End plan --- ##


inicio:
	#prologue
	sw $sp 0($sp)
	sw $fp -4($sp)
	sw $s0 -8($sp)
	sw $s1 -12($sp)
	sw $a0 -16($sp)
	sw $a1 -20($sp)
	sw $a2 -24($sp)
	sw $a3 -28($sp)
	sw $v0 -32($sp)
	sw $v1 -36($sp)
	sw $t0 -40($sp)
	move $fp $sp
	addiu $sp $sp -44
	
	jal map_crear
	nop
	sw $v0 map
	
	jal list_crear
	sw $v1 snek				# Creating the snek
	
	
	#############
	lw $a0 map
	li $a1 1 
	li $a2 1
	lw $a3 cuerpo
	jal matrix_insert
	nop
	
	li $a0 1 
	li $a1 1
	jal Pair
	
	lw $a0 snek
	move $a1 $v1
	jal list_push
	####################
	
	lw $a0 map
	li $a1 1 
	li $a2 2
	lw $a3 cuerpo
	jal matrix_insert
	nop
	
	li $a0 1 
	li $a1 2
	jal Pair
	
	lw $a0 snek
	move $a1 $v1
	jal list_push
	#####################
	lw $a0 map
	li $a1 1 
	li $a2 3
	lw $a3 cuerpo
	jal matrix_insert
	nop
	
	li $a0 1 
	li $a1 3
	jal Pair
	
	lw $a0 snek
	move $a1 $v1
	jal list_push
	##################
	lw $a0 map
	li $a1 1 
	li $a2 4
	lw $a3 cuerpo
	jal matrix_insert
	nop
	
	li $a0 1 
	li $a1 4
	jal Pair
	
	lw $a0 snek
	move $a1 $v1
	jal list_push
	##################
	lw $a0 map
	li $a1 1 
	li $a2 5
	lw $a3 cabeza
	jal matrix_insert
	nop
	
	li $a0 1 
	li $a1 5
	jal Pair
	
	lw $a0 snek
	move $a1 $v1
	jal list_push
	####################
	#Loading movement direction.
	lw $a0 s_movement
	sw $a0 prev_movement
	
	
	jal bad_apple
	
	li $s0 0
	li $s1 0
	lw $s2 N
	lw $s3 M 
	map_print_loop_i:
		beq $s0 $s2 fin_imprimir
		nop
		li $s1 0
		map_print_loop_j:
		beq $s1 $s3 end_j
		nop
		lw $a0 map
		move $a1 $s0
		move $a2 $s1
		jal matriz_obtener
		nop
		move $a0 $s0
		move $a1 $s1
		move $a2 $v0
		jal display
		nop
		addi $s1 $s1 1
		j map_print_loop_j
		nop
		end_j:
		addi $s1 $s1 1
		j map_print_loop_i
		nop
	fin_imprimir:
	#epilogue
	addiu $sp $sp 44
	lw $fp -4($sp)
	lw $s0 -8($sp)
	lw $s1 -12($sp)
	lw $a0 -16($sp)
	lw $a1 -20($sp)
	lw $a2 -24($sp)
	lw $a3 -28($sp)
	lw $v0 -32($sp)
	lw $v1 -36($sp)
	lw $t0 -40($sp)
	jr $ra
