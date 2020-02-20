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
	addiu $sp $sp -12
	sw $fp ($sp)
	sw $ra 4($sp)
	sw $s0 8($sp)	
	
	move $s0 $a0
	li $v0 9
	li $a0 4
	syscall
	
	bltz $v0 Pair_mem_unavailable
	move $v1 $v0							# now $v1 holds the address of the structure
	sw $s0 ($v1)							# storing the first element in the Pair
	sw $a1 ($v1)							# storing the second element in the pair.
	j Pair_exit
	
	Pair_mem_unavailable:
		li $v0 -1
		li $v1 0
		j Pair_exit
	
	Pair_exit:
		move $a0 $s0
		# Epilogue
		sw $fp ($sp)
		sw $ra 4($sp)
		sw $s0 8($sp)
		addiu $sp $sp 12
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
	addiu $sp $sp -4
	sw $fp ($sp)	
	
	lw $v0 ($a0)
	
	sw $fp ($sp)
	addiu $sp $sp 4
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
	addiu $sp $sp -4
	sw $fp ($sp)	
	
	lw $v0 4($a0)
	
	sw $fp ($sp)
	addiu $sp $sp 4
	jr $ra