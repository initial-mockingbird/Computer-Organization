## --- HEADER Structure --- ##
#
#	~HEADER address
#	~SNAKE size
#	~NEXT Available POS
#

## --- Plan snek_HEADER_create --- ##
#
# In Params:
#	$a0: Snake size
#
# Out Params:
#	$v0: HEADER address
#
# Method Variables:
#	
# Side Effects
#	A HEADER for the snek structure is created.
#	ONLY THE HEADER, NOT THE SNEK STRUCTURE OR ANYTHING ELSE.
#
## --- End Plan --- ##

create_snekHDR:
	#PROLOGO
	sw	$fp, 0($sp)
	sw	$ra, -4($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -8
	
	move	$t0, $a0
	
	li	$a0, 12	# We allocate memory for the HEADER	
	li	$v0, 9	# We allocate the required
	syscall
	
	sw	$v0, 0($v0)	# We store HEADER address
	sw	$t0, 4($v0)	# We store snek size
	sw	$zero, 8($v0)	# We store next available position/elements inside 
	
	#EPILOGO
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, -4($sp)
	
	jr	$ra
	