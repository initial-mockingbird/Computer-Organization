## --- Plan map_crear --- ##
#
# In params:
#	$a0: Game DIFFICULTY <NOT IMPLEMENTED>
#	
# Out params:
#	$v0: Map Matrix HEADER
#
# Method vars:
#	$s0: HEADER address
#	$s1: Iteration row
#	$s2: Iteration column
#	$s3: N-1
#	$s4: M-1
#
# Side Effects: 
#	A representation of the map is created in memory
#
## --- End plan --- ##

.data 
WALLS:	.byte '#'
#N:	.word 8
#M:	.word 16
.text

map_crear:
	#PROLOGO
	sw	$fp, 0($sp)
	sw	$ra, -4($sp)
	sw	$s0, -8($sp)
	sw	$s1, -12($sp)
	sw	$s2, -16($sp)
	sw	$s3, -20($sp)
	sw	$s4, -24($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -28
	
	lw	$a0, N
	lw	$a1, M
	
	# Guardamos registros necesarios proximamente
	sw	$a0, 0($sp)
	sw	$a1, -4($sp)
	addiu	$sp, $sp, -8
	
	jal	matrix_create
	
	lw	$a0, 8($sp)
	lw	$a1, 4($sp)
	addiu	$sp, $sp, 8

	
	move	$s0, $v0	# Header Address
	li	$s1, 0	# act row
	li	$s2, 0	# act col
	
	move	$s3, $a0 #N/ROWS
	addi	$s3, $s3, -1
	move	$s4, $a1
	addi	$s4, $s4, -1 # COL - 1
	
	j	row_loop
	
row_loop:
	beqz	$s1, in_col_loop
	beq	$s1, $s3, in_col_loop
	bge	$s1, $s3, exit_map_crear
	
	# Pared borde izq
	move	$a0, $s0
	move	$a1, $s1
	li	$a2, 0
	lb	$a3, WALLS
	
	jal 	matrix_insert
	
	#Pared borde derecha
	move	$a0, $s0
	move	$a1, $s1
	move	$a2, $s4
	lb	$a3, WALLS
	
	
	jal 	matrix_insert
	
	
	addi	$s1, $s1, 1	# Aumentamos la fila en la que estamos
	j	row_loop
	
in_col_loop:
	li	$s2, 0
	j	col_loop
	
col_loop:
	move	$a0, $s0
	move	$a1, $s1
	move	$a2, $s2
	lb	$a3, WALLS
	
	jal 	matrix_insert
	
	addi	$s2, $s2, 1
	
	ble	$s2, $s4, col_loop	# Mientras la colact < M-1 ver esto
	addi	$s1, $s1, 1	# Aumentamos la fila en la que estamos
	j	row_loop

exit_map_crear:
	# EPILOGO
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, 4($sp)
	lw	$s0, 8($sp)
	lw	$s1, 12($sp)
	lw	$s2, 16($sp)
	lw	$s3, 20($sp)
	lw	$s4, 24($sp)
	
	move	$v0, $s0	# En caso de que $v0 haya sido reemplazado
	
	jr	$ra

# INCLUDES NECESARIOS EN ALGUNA PARTE
#.include "Matrix/matrix_HEADER.asm"
#.include "Matrix/matrix_crear.asm"
#.include "Matrix/matrix_insert.asm"
