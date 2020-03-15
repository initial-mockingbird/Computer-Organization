## --- Plan map_crear --- ##
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
#	A representation of the map is created in memory
#
# Example:
#
## --- End plan --- ##

.data 
WALLS:	.byte '#'

.text

map_crear:
	#PROLOGO
	sw	$fp, 0($sp)
	sw	$ra, -4($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -8
	
	lw	$a0, N
	lw	$a1, M
	
	# Creamos una matriz que servira para representar el mapa
	#lw	$t0, N
	#lw	$t1, M
	
	# Guardamos registros necesarios proximamente
	sw	$a0, 0($sp)
	sw	$a1, -4($sp)
	addiu	$sp, $sp, -8
	
	jal	matrix_create
	
	lw	$a0, 8($sp)
	lw	$a1, 4($sp)
	addiu	$sp, $sp, 8
	
	#
	#S0 HEader address
	#S1 Act row
	#S2 act col
	#S3 N
	#S4 M-1
	
	move	$s0, $v0# Header Address
	li	$s1, 0	# act row
	li	$s2, 0	# act col
	
	move	$s3, $a0 #N/ROWS
	move	$s4, $a1
	addi	$s4, $s4, -1 # COL - 1
	
	j	row_loop
	
row_loop:
	beqz	$s1, in_col_loop
	beq	$s1, $s4, in_col_loop
	bge	$s1, $s3, exit_map_crear
	
	# Pared borde izq
	move	$a0, $s0
	move	$a1, $s1
	li	$a2, 0
	lb	$a3, WALLS
	
	# Guardamos $v0 y $a0 porsia
	#sw	$v0, 0($sp)
	#sw	$a0, 4($sp)
	#addiu	$sp, $sp, -8
	
	jal 	matrix_insert
	
	#lw	$v0, 8($sp)
	#lw	$a0, 4($sp)
	#addiu	$sp, $sp, 8
	
	#Pared borde derecha
	#move	$a0, $s2
	#move	$a1, $s1
	move	$a0, $s0
	move	$a1, $s1
	move	$a2, $s4
	lb	$a3, WALLS
	
	# Guardamos $v0 porsia
	#sw	$v0, 0($sp)
	#addiu	$sp, $sp, -4
	
	jal 	matrix_insert
	
	#lw	$v0, 4($sp)
	#addiu	$sp, $sp, 4
	
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
	# HACER EPILOGO
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, 4($sp)
	
	move	$v0, $s0
	
	jr	$ra

