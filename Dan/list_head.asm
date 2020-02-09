##### ---Double-linked list header type implementation---  ####
#
#	header: Register type structure that holds 2 fields:
#
#	-- list_head:: address (word) which holds the address in which the 
#		structure is hold.
#
#	-- Point2Comp:: address (word), which is a pointer to the 
#		comparison function of the element.
#
#  -- Point2Print:: address (word), which is a pointer to the
#		printing function of the element.
#
#	Note: In the abstract, if we  take advantage of the sum and product types,
#			we could write the following type signatures:
#
#	header :: header_pointer x fun_pointer x fun_pointer 
#
# 	where: X_pointer:: address

.data
	list_head:		.word 0
	Point2Comp: 	.word 0
	Point2Print: 	.word 0
.text

	.globl create_header, get_comp, get_print, set_comp, set_print


## --- Plan create_header --- ##
#
# In params:
#	$a0: Pointer to compare function
#	$a1: Pointer to print function.
#
# Out params:
#	$v0: error code 0|-1 for success|failure.
#	$v1: address of the header-like structure.
#
# Method vars: <NONE>
#
# Side Effects: 
#	Point2Comp and Point2Print now stores the pointers
#	to both functions and a new list_head object is created.
#
# Example:
#
## --- End plan --- ##
create_header:									
	addi $sp $sp -4				# before we ask for memory, we preserve $a0.
	sw $a0, ($sp)                
	
   li $v0 9
   li $a0 16						# We ask for memory.
   syscall
   
   
   lw $a0 ($sp)					# Restoring the $a0
   addi $sp $sp 4
   
   beqz $v0 mem_unavailable
      
   sw $v0 ($v0)					# storing the address in the structure.
	sw $a0 4($v0)					# storing the compare pointer in the structure.
	sw $a1 8($v0)					# storing the print pointer in the structure.
	
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
get_comp:
	lw $v0 4($a0)
	jr $ra
	
## --- Plan get_print --- ##
#
# In params:
#	$a0: Pointer to head-like structure.
#
# Out params:
#	$v0: Pointer to printing function.
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
get_print:
	lw $v0 8($a0)
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
set_comp:
	sw $a1 4($a0)
	jr $ra


## --- Plan set_print --- ##
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
set_print:
	sw $a1 8($a0)
	jr $ra














