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
	Point2Comp: 		.word 0
	Point2Hash: 		.word 0
	Number_Classes:	.word 0
.text

	.globl create_header_hash, get_comp_hash, get_hash_hash,get_number_part_hash, set_comp_hash, set_hash_hash, set_number_part_hash


## --- Plan create_header --- ##
#
# In params:
#	$a0: Number of equivalence classes.
#	$a1: Pointer to hash function.
#	$a2: Pointer to compare function
#
#
# Out params:
#	$v0: error code 0|-1 for success|failure.
#	$v1: address of the header-like structure.
#
# Method vars: <NONE>
#
# Side Effects: 
#	Point2Comp and Point2Hash now stores the pointers
#	to both functions, and a new list_head object is created.
#
# Example:
#
## --- End plan --- ##
create_header_hash:									
	addi $sp $sp -4				# before we ask for memory, we preserve $a0.
	sw $a0 ($sp)                
	
   li $v0 9
   li $a0 16						# We ask for memory.
   syscall
   
   
   lw $a0 ($sp)					# Restoring the $a0
   addi $sp $sp 4
   
   beqz $v0 mem_unavailable
      
   sw $v0 ($v0)					# storing the address in the structure.
	sw $a2 4($v0)					# storing the compare pointer in the structure.
	sw $a1 8($v0)					# storing the hash pointer in the structure.
	sw $a0 12($v0)					# storing the number of equivalence classes.
	
	li $v1 0							# now we only have to do a switch.
	
	xor $v0 $v0 $v1
	xor $v1 $v0 $v1				# swtiching the values
	xor $v0 $v0 $v1 
				
	jr $ra


	mem_unavailable:
			li	$v0 -1
			li $v1  0
			jr	$ra

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
	lw $v0 4($a0)
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
	lw $v0 8($a0)
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
	lw $v0 12($a0)
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
	sw $a1 4($a0)
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
	sw $a1 8($a0)
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
	sw $a1 12($a0)
	jr $ra


