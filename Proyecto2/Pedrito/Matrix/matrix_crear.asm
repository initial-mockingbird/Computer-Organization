##### ---Matrix type implementation---  ####
#
#	Matrix: Register type structure that holds 1 fields and then its data:
#
#	-- Matrix_head:: address (word) which holds the address in which the 
#	HEADER structure is located
#
#	-- Matrix Data: Its stored by rows
#
## --- Plan matrix_create --- ##
#
# In params:
#	$a0: Number of rows
#	$a1: Number of columns
#
# Out params:
#	$v0: address of the header-of the matrix
#	$v1: address of the data of the matrix
#
# Method vars: <NONE>
#
# Side Effects: 
#	A MATRIX type for the matrix structure is created in memory
#
# Example:
#
## --- End plan --- ##

#.globl matrix_create
.text

matrix_create:
	#Prologue
	sw	$fp, 0($sp)
	move	$fp, $sp
	sw	$ra, -4($sp)
	addi	$sp, $sp, -8
	
	# Firs we create the HEADER LIKE structure
	# We store $a0 (rows) & $a1 (columns)
	sw	$a0, 0($sp)
	sw	$a1, -4($sp)
	addi	$sp, $sp, -8
	
	jal	create_matr_hdr
	
	move	$t1, $v0	# We store HEADER address temporaly
	
	# We restore rows and colums
	addi 	$sp, $sp, 8
	lw	$a0, 0($sp)
	lw	$a1, -4($sp)
	
	mul	$t0, $a0, $a1	# We calculate number of elements and bytes required to store them
	addi	$t0, $t0, 4	# We add the HEADER address space too
	
	
	
	# We allocate the memory for the HEADER and the matrix data
	move	$a0, $t0
	li	$v0, 9
	syscall
	
	# We store HEADER address in matrix structure
	sw	$t1, 0($v0)
	
	# We calculate DATA first element address
	move	$v1, $v0
	addi	$v1, $v1, 4	# We return MATRIX DATA first element address
	move	$v0, $t1	# We return HEADER address
	
matrix_crear_exit:
	#Epilogue
	move	$sp, $fp
	lw	$fp, 0($fp)
	lw	$ra, -4($sp)
	
	jr	$ra
