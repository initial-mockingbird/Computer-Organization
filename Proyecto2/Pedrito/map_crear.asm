## --- Plan map_crear --- ##
#
# In params:
#	$a0: Matrix Header Address
#	$a1: Game Difficulty <NOT IMPLEMENTED>
#
# Out params: <NONE>
#	DEVOLVER DIRECCION HEADER SOBRETODO
# Method vars: <NONE>
#
# Side Effects: 
#	A representation of the map is created in memory
#
# Example:
#
## --- End plan --- ##

.data 
WALLS:	.byte '#'

.text
map_crear:
	#prologo
	
	# Creamos una matriz que servira para representar el mapa
	lw	$s0, N
	lw	$s1, M
	
	jal	matrix_create
	
	
	move	$s2, $v0# Header Address
	li	$s3, 0	# act row
	li	$s4, 0	# act col
	
	move	$s5, $s1
	addi	$s5, $s5, -1 # COL - 1
	
	j	row_loop
	
row_loop:
	beqz	$s3, in_col_loop
	beq	$s3, $s5, in_col_loop
	bge	$s3, $s0, exit_map_crear
	
	move	$a0, $v0
	move	$a1, $s3
	li	$a2, 0
	lb	$a3, WALLS
	jal 	matrix_insert
	
	move	$a0, $s2
	move	$a1, $s3
	move	$a2, $s5
	lb	$a3, WALLS
	jal 	matrix_insert
	
	addi	$s3, $s3, 1
	j	row_loop
	
in_col_loop:
	li	$s4, 0
	j	col_loop
	
col_loop:
	move	$a0, $s2
	move	$a1, $s3
	move	$a2, $s4
	lb	$a3, WALLS
	jal 	matrix_insert
	addi	$s4, $s4, 1
	
	blt	$s4, $s1, col_loop
	addi	$s3, $s3, 1
	j	row_loop

exit_map_crear:
	# HACER EPILOGO
	jr	$ra