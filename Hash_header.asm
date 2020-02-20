##### ---Hashtable header type implementation---  ####
#
#	header: Register type structure that holds 3 fields:
#
#	-- Hash_head:: address (word) which holds the address in which the 
#	structure is hold.
#
#	-- Point2Comp:: address (word), which is a pointer to the 
#	comparison function of the element.
#
#	-- Point2Hash:: address (word), which is a pointer to the
#	hashing function of the element.
#
#	-- Number_Classes:: int, which represents the number of equivalence
#	classes that partitions the set.
#

.data
	Hash_head:			.word 0
	HHPoint2Comp: 		.word 0
	HHPoint2Hash: 		.word 0
	HHNumber_Classes:	.word 0
	HHPoint2Print:		.word 0
	PairComp:			.word 0			# Global address which is used as a aux variable in order to perform
												# a curry version of the pair compare function and be able to pass
												# it to the list as a 2 argument function.
.text

	.globl PairComp, HC_compare


## --- Plan create_header --- ##
#
# In params:
#	$a0: Number of equivalence classes.
#	$a1: Pointer to hash function.
#	$a2: Pointer to compare function.
#	$a3: Pointer to the print function.
#
#
# Out params:
#	$v0: error code 0|-1 for success|failure.
#	$v1: address of the header-like structure.
#
# Method vars: <NONE>
#
# Side Effects: 
#	Point2Comp, Point2Print and Point2Hash now stores the pointers
#	to the three functions, and a new list_head object is created.
#
# Example:
#
## --- End plan --- ##
create_header_hash:									
	# Prologue
	sw $fp 0($sp)
	sw $ra -4($sp)                
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $a2 -16($sp)
	sw $a3 -20($sp)
	move $fp $sp
	addi $sp $sp -24			
	
   li $v0 9
   li $a0 20						# We ask for memory.
   syscall
   lw $a0 16($sp)
   sw $v0 ($v0)					# storing the address in the structure.
	sw $a2 4($v0)					# storing the compare pointer in the structure.
	sw $a1 8($v0)					# storing the hash pointer in the structure.
	sw $a0 12($v0)					# storing the number of equivalence classes.
	sw $a3 16($v0)					# storing the pointer to the printing function. 
	
	sw $a2 PairComp				# storing the compare function in the global label.
	
   bltz $v0 Hhmem_unavailable
      
	li $v1 0							# now we only have to do a switch.
	
	xor $v0 $v0 $v1
	xor $v1 $v0 $v1				# swtiching the values
	xor $v0 $v0 $v1 
				
	j endCreateHeader
	

	Hhmem_unavailable:
		li	$v0 -1
		li $v1  0
		j endCreateHeader

	endCreateHeader:
		
		# Epilogue
		addi $sp $sp 24
		lw $fp 0($sp)
		lw $ra -4($sp)                
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $a2 -16($sp)
		lw $a3 -20($sp)
		jr $ra
		
		

## --- Plan get_comp --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#
# Out params:
#	$v0: Pointer to comparison function.
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
get_comp_hash:
	# Prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	lw $v0 4($a0)
	
	# Epilogue
	addi $sp $sp 4
	lw $fp ($sp)
	
	jr $ra
	
## --- Plan get_hash --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#
# Out params:
#	$v0: Pointer to hash function.
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
get_hash_hash:
	# Prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	lw $v0 8($a0)
	
	# Epilogue
	addi $sp $sp 4
	lw $fp ($sp)
	jr $ra

	
		
			
## --- Plan get_number_part --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#
# Out params:
#	$v0: number of equivalence classes.
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
get_number_part_hash:
	# Prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	lw $v0 12($a0)
	
	# Epilogue
	addi $sp $sp 4
	lw $fp ($sp)
	jr $ra			
					
## --- Plan get_print_hash --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#
# Out params:
#	$v0: print function of the hash strucutre..
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
get_print_hash:
	# Prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	lw $v0 16($a0)
	
	
	# Epilogue
	addi $sp $sp 4
	lw $fp ($sp)
	jr $ra			
					
## --- Plan set_comp --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#	$a1: value to set.
#
# Out params: <NONE>
#
# Method vars: <NONE>
#
# Side Effects: 
#	The comparison function is changed.
#
# Example:
#
## --- End plan --- ##
set_comp_hash:
	# Prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	sw $a1 4($a0)
	
	# Epilogue
	addi $sp $sp 4
	lw $fp ($sp)
	jr $ra


## --- Plan set_hash --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#	$a1: value to set.
#
# Out params: <NONE>
#
# Method vars: <NONE>
#
# Side Effects: 
#	The printing function is changed.
#
# Example:
#
## --- End plan --- ##
set_hash_hash:
	# Prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	sw $a1 8($a0)
	
	# Epilogue
	addi $sp $sp 4
	lw $fp ($sp)
	jr $ra




## --- Plan set_number_part --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#	$a1: value to set.
#
# Out params: <NONE>
#
# Method vars: <NONE>
#
# Side Effects: 
#	The number of equivalence classes is changed.
#
# Example:
#
## --- End plan --- ##
set_number_part_hash:
	# Prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	sw $a1 12($a0)
	
	# Epilogue
	addi $sp $sp 4
	lw $fp ($sp)
	jr $ra


## --- Plan set_number_part --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#	$a1: value to set.
#
# Out params: <NONE>
#
# Method vars: <NONE>
#
# Side Effects: 
#	The number of equivalence classes is changed.
#
# Example:
#
## --- End plan --- ##
set_print_hash:
	# Prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	sw $a1 16($a0)
	
	
	# Epilogue
	addi $sp $sp 4
	lw $fp ($sp)
	jr $ra




## --- HC_compare --- ##
#
# In params:
#	$a0: Pointer to first pair.
#	$a1: Pointer to second pair.
#
# Out params: 
#
#	$v0: the result of the compare.
#
# Method vars: <NONE>
#
# Side Effects: 
#	The number of equivalence classes is changed.
#
# Remark: 
#
#	HC_compare(x,y) = -1 if fst(x)<fst(y)
#	HC_compare(x,y) = 0 if fst(x)==fst(y)
#	HC_compare(x,y) = 1 if fst(x)>fst(y)
#
## --- End plan --- ##
HC_compare: 
	# Prologue
	sw $fp ($sp)
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	move $fp $sp
	addi $sp $sp -16

	
	
	jal Pair_snd
	move $a0 $a1
	move $a1 $v0
	
	jal Pair_snd
	move $a0 $a1
	move $a1 $v0
	lw $a2 PairComp
	
	jalr $a2 

	# Epilogue
	addi $sp $sp 16
	lw $fp ($sp)
	lw $ra -4($sp)
	lw $a0 -8($sp)
	lw $a1 -12($sp)
	
	jr $ra
