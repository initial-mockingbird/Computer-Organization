##### ---Hashtable contents type implementation---  ####
#
#	contents: Register type structure that holds 3 fields:
#
#	-- HashContents_head:: address (word) which marks the beginning of the HashtableArray.
#
#	-- Point2Comp:: address (word), which is a pointer to the 
#	comparison function of the element.
#
#	-- Point2Hash:: address (word), which is a pointer to the
#	hashing function of the element.
#
#	-- Point2Print:: address (word) which is a pointer to the
#	printing function of the element.
#
#	-- Number_Classes:: int, which represents the number of equivalence
#	classes that partitions the set.
#

.data

HCHashContents_head:		.word 0
HCPoint2Comp:				.word 0
HCPoint2Hash:				.word 0
HCNumber_Classes:			.word 0
HCPoint2Print:				.word 0

.text


## --- Plan create_header --- ##
#
# In params:
#	$a0: Address of the hashtable object that is linked with.
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
create_content_hash:
	#Prologo
	addi $sp $sp -44		
	sw $fp ($sp)		
	sw $ra 4($sp)
	sw $a0 8($sp)
	sw $a1 12($sp)
	sw $a2 16($sp)
	sw $a3 20($sp)
	sw $s0 24($sp)
	sw $s1 28($sp)
	sw $s2 32($sp) 
	sw $s3 36($sp)
	sw $s4 40($sp)   
	
	move $s0 $a0		# now $s0 holds the address of the hashtable.
	addi $a0 $a0 4
	lw $a0 ($a0)
	jal get_number_part_hash
	move $a0 $v0
	move $s1 $v0		# now $s1 holds the number of partitions	
	mul  $a0 $a0 4 	# and $a0 holds how much space do we need
	
	li $v0 9				# we have precalculated how much space we needed.
   syscall
	
	bltz $v0 HTCmem_unavailable 
	move $s4 $v0		# $s4 now holds the address of the array.
	
	addi $a0 $s0 4		# $a0 now points to the hash header
	lw   $a0 ($a0)
	jal get_comp_hash
	move $s2 $v0		# $s2 now has the compare function of the table construct.
 	
	addi $a0 $s0 4		# $a0 now points to the hash header
	lw $a0 ($a0)
	jal get_print_hash
	move $s3 $v0		# $s2 now has the print function of the table construct.
	move $s0 $s4

	# all that's left is to create a list in each of the table positions.
	# note that at this point we hace:
	# -$s0: pointer to the address of the hashtable
	# -$s1: number of partions.
	# -$s2: the compare function of the hash table.
	# -$s3: the print function of the hash table.
	# -$s4: the address of the array
		
	filling_hash_table:
		beqz $s1 endCreateContent
		move $a0 $s4		# cargamos la direccion sobre la cual vamos a crear la lista.
		move $a1 $s2		# cargamos la funcion de comparacion
		move $a3 $s3			# y no cargamos funcion de impresion alguna.
		jal list_crear
		bltz $v0 HTCmem_unavailable 
		sw $v1 ($s4)
		addiu $s4 $s4 4
		addi $s1 $s1 -1 
		j filling_hash_table
	
	
	
	HTCmem_unavailable:
		li $v0 -1
		li $v1 0
		j hashContentend
	endCreateContent:
		li $v0 0
		move $v1 $s0
	hashContentend:
		#Epilogo
		lw $fp ($sp)		
		lw $ra 4($sp)
		lw $a0 8($sp)
		lw $a1 12($sp)
		lw $a2 16($sp)
		lw $a3 20($sp)
		lw $s0 24($sp)
		lw $s1 28($sp)
		lw $s2 32($sp) 
		lw $s3 36($sp)
		lw $s4 40($sp)   
		addi $sp $sp 44
		jr $ra	

