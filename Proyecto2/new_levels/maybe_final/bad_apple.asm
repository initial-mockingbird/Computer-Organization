## --- Plan display --- ##
#
# In params: <NONE>
#
# Out params: <NONE>
#
# Method vars: 
#
#	- $a0: used to generate random number 
#	- $a1  used to generate random number 
#	- $a2  used to verify if a side-way was already generated on the spot.
#	- $a3  used to insert in matrix.
#	- $v0  used to generate random number 
#	- $v1  used to generate random number 
#	- $t0  used to hold aux variables such as head/body/wall characters.
#
# Side Effects: 
#	A new apple is printed at the screen, saved at the map, and the score goes up by 1.
#
# Example:
#
## --- End plan --- ##
	bad_apple:
	#prologue
	sw $fp ($sp)
	sw $ra -4($sp)
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
	
	# --- Increasing the highscore --- #
	lw $a0 puntaje
	addi $a0 $a0 1
	sw $a0 puntaje
	
	# --- Generating coordinates --- #
	gen_apple:
	#--x--#
	
	li $v0 42
	lw $a1 N
	addi $a1 $a1 -2
	syscall
	addi $a0 $a0 1
	move $v1 $a0
	move $a2 $v1
	sw $a0 coord_manzana
	
	#--y--#
	li $v0 42
	lw $a1 M
	addi $a1 $a1 -2
	syscall
	addi $a0 $a0 1
	move $a3 $a0
	sw $a0 coord_manzana+4
	
	lw $a0 map
	lw $a1 coord_manzana
	lw $a2 coord_manzana+4
	jal matriz_obtener
	lw $t0 pared
	beq $t0 $v0 gen_apple
	nop
	lw $t0 cuerpo
	beq $t0 $v0 gen_apple
	nop
	lw $t0 cabeza
	beq $t0 $v0 gen_apple
	nop
	
	lw $a0 coord_manzana
	lw $a1 coord_manzana+4
	
	# --- Displaying  --- #
	lw $a0 coord_manzana
	lw $a1 coord_manzana+4
	lw $a2 manzana
	jal display
	nop
		
	map_manzana_set:
	lw $a0 map
	lw $a1 coord_manzana
	lw $a2 coord_manzana+4
	lw $a3 manzana
	jal matrix_insert
	nop
	
	
	# Actualizando puntaje:
	#lw $a0 N
	#div $a0 $a0 2
	#addi $a0 $a0 1
	
	#lw $a1 M
	#addi $a1 $a1 6 
	
	#lw $a2 puntaje
	
	#jal display
	
	#epilogue
	addiu $sp $sp 44
	lw $fp ($sp)
	lw $ra -4($sp)
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
	
