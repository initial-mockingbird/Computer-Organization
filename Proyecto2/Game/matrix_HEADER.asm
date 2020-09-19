##### ---Matrix header type implementation---  ####
#
#	Header: Register type structure that holds 3 fields:
#
#	-- Matrix_head:: address (word) which holds the address in which the 
#	HEADER structure is holer
#
#	-- Rows: Integer (word) which is the number of rows in the matrix.
#
#	-- Columns: Integer (word) which is the number of columns in the matrix.
#
## --- Plan create_matr_header --- ##
#
# In params:
#	$a0: Number of rows
#	$a1: Number of columns
#
# Out params:
#	$v0: address of the header-like structure.
#
# Method vars: <NONE>
#
# Side Effects: 
#	A HEADER type for the matrix structure is created in memory
#
# Example:
#
## --- End plan --- ##
.text
.globl create_matr_hdr

create_matr_hdr:
	#Prologue
	sw	$fp, 0($sp)
	move	$fp, $sp
	addi	$sp, $sp, -4
	
	move	$t0, $a0	# We preserve row number 
	
	li	$v0, 9
	li	$a0, 12
	syscall
	
	sw	$v0, 0($v0)	# Header.address
	sw	$t0, 4($v0)	# Header.rows
	sw	$a1, 8($v0)	# Header.columns

create_matr_hdr_exit:
	#Epilogue
	move	$sp, $fp
	lw	$fp, 0($sp)
	
	jr	$ra