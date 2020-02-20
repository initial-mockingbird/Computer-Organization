##### ---Double-linked list element type implementation---  ####
#
#	Element: Register type structure that holds 3 fields:
#	
#	-- list_elem: address (word) which holds the address in which the 
#		structure is hold.
#
#	-- Value:: element (word), which is  the value
#		that is currently stored in some index of the list.
#
#	-- Prev:: address (word), which is a pointer to the previous
#		element in the list, if it is the head of the list, then it
#		points to null: 0x00000000.
#
#	-- Next:: address (word), which is a pointer to the next
#		element in the list, if it is the tail of the list, then it
#		points to null: 0x00000000.
#
#
#	Note: In the abstract, if we  take advantage of the sum and product types,
#			we could write the following type signatures:
#
#	elementDLL :: list_elem_pointer x Value x Prev x Next
#	Prev:: elementDLL + Null
#	Next:: elementDLL + Null



.data
	list_elem:		.word 0
	Value:			.word 0
	Prev:				.word 0
	Next:				.word 0
	Null:				.word 0xffffffff
.text

	.globl create_list_elem, get_value, get_prev, get_next, set_value, set_prev, set_next, compare_elements

## --- Plan create_list_elem --- ##
#
# In params:
#	$a0: value to wrap.
#
# Out params:
#	$v0: address of the list_elem like structure.
#
# Method vars: <NONE>
#
# Side Effects: 
#	A list_elem like structure is created.
#
# Examples:
#
## --- End plan --- ##
create_list_elem:
	addi $sp $sp -4 				# before we ask for memory, we preserve $a0.
	sw $a0, ($sp)                       
	
   li $v0 9
   li $a0 16						# We ask for memory.
   syscall
   
   lw $a0 ($sp)					# Restoring the $a0.
   addi $sp $sp 4
   
   addi $sp $sp -4 				# preserving $t0 for callers commodity.
	sw $t0, ($sp) 
   
   li $t0 0xffffffff
   
   sw $v0 ($v0)					# storing the address in the structure.
	sw $a0 4($v0)					# storing the value in the structure.
	sw $t0 8($v0)					# storing null in Prev
	sw $t0 12($v0)					# storing null in Next.
	
	lw $t0 ($sp)					# Restoring  $t0.
   addi $sp $sp 4
   
	jr $ra
	

# get_value (adress) -> list_elem.Value/Error code
## --- Plan get_value --- ##
#
# In params:
#	$a0: address of the list_elem object.
#
# Out params:
#	$v0: Value of the list_elem object pointed by $a0.
#
# Method Vars: 	<NONE>
#
# Side Effects: 	<NONE>
#
# Examples:
#
## --- End plan --- ##
get_value:
	lw $v0 4($a0)
	jr $ra


## --- Plan get_prev --- ##
#
# In params:
#	$a0: address of the list_elem object.
#
# Out params:
#	$v0: Pointer to the previous list_elem object pointed by $a0.
#
# Method Vars: 	<NONE>
#
# Side Effects: 	<NONE>
#
## --- End plan --- ##
get_prev:
	lw $v0 8($a0)
	jr $ra


## --- Plan get_next --- ##
#
# In params:
#	$a0: address of the list_elem object.
#
# Out params:
#	$v0: Pointer to the next list_elem object pointed by $a0.
#
# Method Vars: 	<NONE>
#
# Side Effects: 	<NONE>
#
## --- End plan --- ##
get_next:
	lw $v0 12($a0)
	jr $ra
	
## --- Plan set_value --- ##
#
# In params:
#	$a0: address of the list_elem object.
#	$a1: content to set.
#
# Out params: <NONE>
#
# Method Vars: 	<NONE>
#
# Side Effects: 
#	The value of the list_elem object pointed by $a0
#	is set to the contents of $a1.
#
## --- End plan --- ##
set_value:
	sw $a1 4($a0)
	jr $ra

## --- Plan set_prev --- ##
#
# In params:
#	$a0: address of the list_elem object.
#	$a1: prev to set.
#
# Out params: <NONE>
#
# Method Vars: <NONE>
#
# Side Effects: 
#	The prev pointer of the list_elem object pointed by $a0
#	is set to the contents of $a1.
#
## --- End plan --- ##
set_prev:
	sw $a1 8($a0)
	jr $ra

## --- Plan set_next --- ##
#
# In params:
#	$a0: address of the list_elem object.
#	$a1: pointer (next) to set.
#
# Out params: <NONE>
#
# Method Vars: <NONE>
#
# Side Effects: 
#	The next pointer of the list_elem object pointed by $a0
#	is set to the contents of $a1.
#
## --- End plan --- ##
set_next:
	sw $a1 12($a0)
	jr $ra
	
	
## --- Plan compare_elements --- ##
#
# In params:
#	$a0: comparing function.
#	$a1: first object to compare.
#	$a2: second object to compare.
#
#
# Out params: 
#	$v0: result of the compare function.
#
# Method Vars: 
#	$t0 holds value a
#	$t1 holds value b
#
# Side Effects: <NONE>
#
## --- End plan --- ##

compare_elements:

	addi $sp $sp -12 				# preserving the method vars .
	sw $ra ($sp)
	sw $t0 4($sp)
	sw $t1 8($sp)    

	xor $a0 $a0 $a1
	xor $a1 $a0 $a1	# swapping in order to get the value of a
	xor $a0 $a0 $a1
	
	jal get_value
	
	move $t0 $v0		# a resides in $t0
	
	xor $a0 $a0 $a2
	xor $a2 $a0 $a2	# swapping in order to get the value of b
	xor $a0 $a0 $a2
	
	jal get_value
	
	move $t1 $v0		# b resides in $t1 
	
	xor $a1 $a1 $a2
	xor $a2 $a1 $a2	# now $a2 has the compare function
	xor $a1 $a1 $a2

	move $a0 $t0		# loading a in $a0
	move $a1 $t1		# loading b in $a1
	
	jalr $a2				# comparing a and b
	
	lw $ra ($sp)
	lw $t0 4($sp)		# Restoring $t0
	lw $t1 8($sp)		# Restoring $t1
   addi $sp $sp 12
	
	jr $ra				#returning
