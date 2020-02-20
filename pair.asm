##### ---Pair type implementation---  ####
#
#	contents: Register type structure that holds 2 fields:
#
#	-- PairHeader:: address (word) which points to the header of the pair structure.
#
#	-- PairFst:: address (word) which points tothe first element of the array.
#
#	-- PairFst:: address (word), which points to the second element of the 
#



.data
PairFst:		.word 0
PairSnd:		.word 0

.text


## --- Plan Pair --- ##
#
# In params:
#	$a0: Address of the first element of the pair
#	$a1: Address of the second element of the pair
#
#
# Out params:
#	$v0: error code 0|-1 for success|failure.
#	$v1: address of the pair like structure.
#
# Method vars: <NONE>
#
# Side Effects: 
#	A Pair structure is created and returned un $v1.
#
# Example:
#
## --- End plan --- ##

Pair:
	# Prologue
	sw $fp ($sp)
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $s0 -16($sp)	
	move $fp $sp
	addiu $sp $sp -20
	
	move $s0 $a0
	li $v0 9
	li $a0 8
	syscall
	
	bltz $v0 Pair_mem_unavailable
	move $v1 $v0							# now $v1 holds the address of the structure
	sw $s0 ($v1)							# storing the first element in the Pair
	sw $a1 4($v1)							# storing the second element in the pair.
	j Pair_exit
	
	Pair_mem_unavailable:
		li $v0 -1
		li $v1 0
		j Pair_exit
	
	Pair_exit:
		move $a0 $s0
		# Epilogue
		addiu $sp $sp 20
		lw $fp ($sp)
		lw $ra -4($sp)
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $s0 -16($sp)	
		
		jr $ra


## --- Pair_fst --- ##
#
# In params:
#	$a0: Address of the pair strucutre.
#
#
# Out params:
#	$v0: first element of the pair.
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
Pair_fst:
	# Prologue
	sw $fp ($sp)	
	move $fp $sp
	addiu $sp $sp -4
	
	lw $v0 ($a0)
	
	# Epilogue
	addiu $sp $sp 4
	lw $fp ($sp)
	
	jr $ra

## --- Pair_snd --- ##
#
# In params:
#	$a0: Address of the pair strucutre.
#
#
# Out params:
#	$v0: second element of the pair.
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
Pair_snd:
	# Prologue
	sw $fp ($sp)	
	move $fp $sp
	addiu $sp $sp -4
	
	lw $v0 4($a0)
	
	# Epilogue
	addiu $sp $sp 4
	lw $fp ($sp)	
	
	jr $ra
