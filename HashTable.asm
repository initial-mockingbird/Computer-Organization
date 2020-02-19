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
	HHeader:		.word 0
	HContents:	.word 0
.text
	.globl tab_crear

## --- Plan tab_crear --- ##
#
# In params:
#	$a0: Number of equivalence classes (elements) in the array
#	$a1: Pointer to hash function.
#	$a2: Pointer to the compare function
#	$a3: Pointer to the print function.
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
	addi $sp $sp -16		
	sw $fp ($sp)		
	sw $ra 4($sp)
	sw $a0 8($sp)
	sw $s0 12($sp)     
	
	move $s0 $a0	# $t0 now has the number of equivalence classes.
	li $v0 9
   li $a0 12						# We ask for memory.
   syscall
	
	
	
	bltz $v0 HTmem_unavailable
	sw $v0 ($v0) 	# we write the address of the structure.
	move $a0 $s0	# $a0 now holds the number of partitions.
	move $s0 $v0	# $t0 now holds the address of the hashtable.
	jal create_header_hash
	
	bltz $v0 HTmem_unavailable
	sw $v1 4($s0)	# we write the address of the header
	move $a0 $s0	# $a0 holds the adress of the hashtab;e
	move $t0 $v1	# $v1 holds the address of the header structure.
	jal create_content_hash
   
   bltz $v0 HTmem_unavailable
   sw $v1 8($a0) # we write the address of the contents.
   j exit_tab_crear
   
	
	
	HTmem_unavailable:
			li	$v0 -1
			li $v1  0
			j exit_tab_crear
	
	exit_tab_crear:
		lw $fp ($sp)		
		lw $ra 4($sp)
		lw $a0 8($sp)
		lw $s0 12($sp) 
		addi $sp $sp -16	
		jr $ra

.include "Hash_header.asm"
.include "HashTableContents.asm"
.include "TADList.asm"