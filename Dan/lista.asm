##### ---Double-linked list implementation---  ####
#
#	Double-linked list: Register type structure that holds 5 fields:
#
#	-- lista: address (word) which holds the address in which the 
#		structure is hold.
#	
#	-- Element:: list_elem (see the specification), which is the 
#		double-linked list element that is currently stored in some index of the list.
#
#	-- Header :: list_head (see the specification), which is the
#		double-linked list header that holds the comparison function and the print function.
#
#	Note: In the abstract, if we  take advantage of the sum and product types,
#			we could write the following type signatures:
#
#	dLL :: header x list_elem
#

.data
	lista:			.word 0
	Header:			.word 0
	Element:			.word 0
.text
 	.globl list_crear,list_insertar 

# list_crear (address funCompar, funImprime: Int) -> adress:Int/Error code.
## --- Plan list_crear --- ##
#
# In params:
#	$a0: Pointer to compare function.
#	$a1: Pointer to print function.
#
# Out params:
#	$v1: address of the List structure.
#	$v0: error code.
#
# Method vars: 
#	$t0: pointer to the header-like structure.
#
# Side Effects: 
#	Header now stores a pointer to a header-like structure.
#
# Example:
#
## --- End plan --- ##
list_crear: 
	addi $sp $sp -8				# preserving the method vars .
	sw $ra ($sp)
	sw $t0 4($sp)
	
	jal create_header		# We create a header object and store it's reference in $v0.
	
	beq $v0 -1 mem_unavailable	# if there is no memmory, jump to exception.
	
	move $t0 $v1			# $t0 now holds a pointer to the header like structure.

	li $v0 9
   li $a0 12						# We ask for memory.
   syscall
	
	sw $v0 ($v0)			# Storing the address in the structure.
	sw $t0 4($v0)			# Storing the header address in the structure.
	
	li $v1 0xffffffff		
	sw $v1 8($v0)			# Storing null in the element field.
	
	
	li $v1 0					# Exit without errors.
	xor $v1 $v1 $v0
	xor $v0 $v1 $v0		# now $v1 holds the address of the list structure
	xor $v1 $v1 $v0		# and $v0 the error code.
	
	
	lw $ra ($sp)
	lw $t0 4($sp)		# Restoring $t0
   addi $sp $sp 8
	jr $ra
	
# list_insertar (adress adress_List, element) -> Error code
## --- Plan list_insertar --- ##
#
# In params:
#	$a0: address of the list.
#	$a1: element to insert.
#
# Out params:
#	$v0: error code.
#
# Method vars: 
#	$t0: stores the element to insert.
#	$t1: stores the address of the list/pointer to next element..
#	$t3: comparison function.
#	$t4: list address
#
# Side Effects: 
#	the element stored in $a1 is inserted in ascending order.
#
## --- End plan --- ##
list_insertar:
	addi $sp $sp -16				# preserving the method vars .
	sw $ra ($sp)
	sw $t0 4($sp)
	sw $t3 8($sp)
	sw $t4 12($sp)
	
	move $t3 $zero
	
	xor $a0 $a0 $a1
	xor $a1 $a0 $a1	# swapping the values in order to create a list_elem
	xor $a0 $a0 $a1
							# now $a0 contains element to insert and $a1 contains list address.
	
	jal create_list_elem
	
	move $t0 $v0		# getting the wrapper of the element to insert.
	
	move $a0 $a1		# setting $a0 to be the list address.
	move $t4 $a0		# setting $t4 to hold the list address.
	
	addiu $t3 $a0 4	# getting the pointer to the pointer of the header.
	lw $t3 ($t3)		# getting the pointer of the header field.
	move $a0 $t3		# now $a0 holds the pointer to the header structure.
	
	jal get_comp		# getting the compare function. 
	
	move $t3 $v0		# $t3 now holds the compare function.
	
	lw $t1 8($t4)		# gets the first element of the list.
	
	beq $t1 0xffffffff insert_First #if it's the first element to insert 
	
	loop_insert:
		
		move $a0 $t3
		move $a1 $t0	# preparing to compare  the elements
		move $a2 $t1
		
		jal compare_elements
		
		beq $v0 -1 insert  
		
		move $a0 $t1
		jal get_next
		
		beq $v0 0xffffffff insert_Last
		
		j loop_insert
	
	
	insert_First:
		sw $t0 8($t4)		# we store the pointer to the first element
		j end
		
	
	insert:
	
		move $a0 $t0
		move $a1 $t1	# We set the next pointer of the element to insert.
		jal set_next 
	
		move $a0 $t1	
		jal get_prev	# We get the previous element to unlink it.
		move $a0 $t1
		move $a1 $t0	# We set the previous element to the element to insert.
		jal set_prev
		
		beq $v0 0xffffffff replace_inicio # if the previous element was null do nothing.
		
		move $a0 $v0	# preparing to set the prev next.
		move $a1 $t0
		jal set_next
		
		j end
	
	insert_Last:
		move $a0 $t1
		move $a1 $t0
		jal set_next
		
		move $a0 $t0
		move $a1 $t1
		jal set_prev
		j end
		
	replace_inicio:
		sw $t0 8($t4)
		j end
		
	end:
	
		lw $ra ($sp)
		lw $t0 4($sp)
		lw $t3 8($sp)
		lw $t4 12($sp)
		addi $sp $sp 16	
		jr $ra
		
.include "list_elem.asm"
.include "list_head.asm"



