##### ---HashTable  implementation---  ####
#
#	HashTable: Register type structure that holds 3 fields:
#
#	-- Hashtable: address (word) which holds the address in which the 
#	structure is hold.
#	
#	-- Header :: Hash_head (see the specification), which is the
#	HashTable header that holds the comparison function and hashing function.
#
#	-- Contents:: Hash_contents (see the specification), which holds a pointer to 
#	 the Hashtable (Array of lists).
#
#

.data
	Hashtable:	.word 0
	Header:		.word 0
	Contents:	.word 0
.text
	.globl tab_crear

## --- Plan tab_crear --- ##
#
# In params:
#	$a0: Number of equivalence classes (elements) in the array
#	$a1: Pointer to hash function.
#	$a2: Pointer to the compare function
#
# Out params:
#	$v0: error code 0|-1 for success|failure.
#	$v1: address of the content-like structure.
#
# Method vars: 
#	$t0: used to hold the header like strucutre before building
#	the content like strucutre.
#
# Side Effects: 
#	Point2Comp and Point2Hash now stores the pointers
#	to both functions, and a new list_head object is created.
#
# Example:
#
## --- End plan --- ##
tab_crear:
	addi $sp $sp -12				
	sw $ra ($sp)
	sw $a0 4($sp)
	sw $t0 8($sp)     
	
	jal create_header_hash
	
	move $t0 $v1
	
	bltz $v0 mem_unavailable
	
	jal create_content_hash
	
	bltz $v0 mem_unavailable
	
	li $v0 9
   li $a0 12						# We ask for memory.
   syscall
   
   beqz $v0 mem_unavailable
   
   sw $v0 ($v0)
   sw $t0 4($v0)
   sw $v1 8($v0)
   
   j exit_tab_crear
   
	
	
	mem_unavailable:
			li	$v0 -1
			li $v1  0
			j exit_tab_crear
	
	exit_tab_crear
		lw $ra ($sp)
		lw $a0 4($sp)
		lw $t0 8($sp)  
		addi $sp $sp 12
		jr $ra