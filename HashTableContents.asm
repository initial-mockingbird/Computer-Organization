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


## --- Plan create_content_hash --- ##
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
	#Prologue
	sw $fp ($sp)		
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $a2 -16($sp)
	sw $a3 -20($sp)
	sw $s0 -24($sp)
	sw $s1 -28($sp)
	sw $s2 -32($sp) 
	sw $s3 -36($sp)
	sw $s4 -40($sp)   
	move $fp $sp
	addi $sp $sp -44	
	
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
	
	sw $a2 PairComp 			# storing the compare function in the global label.
	filling_hash_table:
		beqz $s1 endCreateContent
		#move $a0 $s4			# cargamos la direccion sobre la cual vamos a crear la lista.
		#la $a1 HC_compare		# cargamos la funcion de comparacion
		la $a0 HC_compare
		#move $a1 $s2			# cargamos la funcion de comparacion
		move $a1 $s3			# y no cargamos funcion de impresion alguna.
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
		#Epilogue
		addi $sp $sp 44
		lw $fp ($sp)		
		lw $ra -4($sp)
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $a2 -16($sp)
		lw $a3 -20($sp)
		lw $s0 -24($sp)
		lw $s1 -28($sp)
		lw $s2 -32($sp) 
		lw $s3 -36($sp)
		lw $s4 -40($sp)   
		jr $ra	


## --- HC_buscar_elemento--- ##
#
# In params:
#	$a0: Address of the linked list object that the element may currently be in.
#	$a1: key to find
#
#
# Out params:
#	$v0: error code 0|-1 for success|failure.
#	$v1: index of the element in the list..
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
HC_buscar_elemento:
	# Prologue
	sw $fp ($sp)
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $s0 -16($sp)
	sw $s1 -20($sp)
	sw $s2 -24($sp)
	move $fp $sp
	addiu $sp $sp -28
	
	jal list_longitud
	
	beqz $v0 HC_noSuchElement		# if there are no elements in the list, then throw no element.
	
	move $s0 $v0						# $s0 now stores the length of the list.
	lw $a1 -12($fp)
	
	li $a0 0
	jal Pair
	bltz $v0 HC_noSuchElement
	move $s2 $v1
	# Now we only have to search through the list to see if the element is in there.
	
	HH_buscar_loop:
		beqz $s0 HC_noSuchElement		# repeat until there are no more elements.
	
		lw $a0 -8($fp)						# $a0 stores the address of the list.
		move $a1 $s0						# $a1 stores the position to discover
		jal list_obtener					# now $v0 has the pair (element,key) that was stored in the index $s0
		bltz $v1 HC_noSuchElement
		move $s1 $v0						# now $s1 stores the pair.
	
		move $a0 $s2
		move $a1 $s1
		jal HC_compare						# compare if  the two elements are the same.
		beqz $v0 HH_found					# if the result is 0 then the elements are equal.
		bgtz $v0 HC_noSuchElement		# if the element in the array is less than the key that we are looking for, 
												# we conclude that there is no element because we are searching in a decreasing order. 
		addi $s0 $s0 -1
	
		j HH_buscar_loop
		
	HC_noSuchElement:
		li $v0 -1
		j HC_buscar_elemento_end
		
	HH_found:
		move $v0 $s0
		
	HC_buscar_elemento_end:
		# Epilogue
		addiu $sp $sp 28
		lw $fp ($sp)
		lw $ra -4($sp)
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $s0 -16($sp)
		lw $s1 -20($sp)
		lw $s2 -24($sp)
		
		jr $ra
	
	
## --- tab_buscar-- ##
#
# In params:
#	$a0: Address of the hashtable object..
#	$a1: key to find
#
#
# Out params:
#	$v0: error code 0|-1 for success|failure.
#	$v1: element associated with the key
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
tab_buscar:
	# Prologue
	sw $fp ($sp)
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $s0 -16($sp)
	sw $s1 -20($sp)
	sw $s2 -24($sp)
	move $fp $sp
	addiu $sp $sp -28
	
	addiu $a0 $a0 4		# $a0 now holds the position of the header.
	lw $a0 ($a0)			# we load the pointer to the header.
	jal get_comp_hash			
	sw $v0 PairComp		# we set PairComp for when we need to do the search on the list.
	
	lw $a0 -8($fp)			# $a0 holds again the address of the hashtable
	addiu $a0 $a0 4		# and now the address of the header.
	lw $a0 ($a0)			# and now a pointer to the header.
	jal get_hash_hash		# we get the position of the array that we need to look for.
	move $a0 $a1			# now it holds the key
	jalr $v0					# we hash it.
	move $s1 $v0			# $s1 holds the position of the array which we need to look.
	lw $a0 -8($fp)			# now $a0 holds the hashtable address again
	addiu $a0 $a0 8		# we move it so it points to the pointer of the contents.
	lw $a0 ($a0)			# we de-reference it and get the pointer.
	mul $v0 $v0 4			# converting to list length
	addu $a0 $a0 $v0		# positioning ourselves in the list.
	lw $a0 ($a0)			# getting the list address

	lw $a1 -12($fp)		# we get the key in order to have: address of list, key and call buscar_elemento.
	
	jal HC_buscar_elemento
	move $s2 $v0
	bltz $v0 tab_buscar_NotFound
	lw $a0 -8($fp)			# reloading the address
	addiu $a0 $a0 8
	lw $a0 ($a0)
	mul $s1 $s1 4		
	addu $a0 $a0 $s1		# positioning ourselves in the list.
	lw $a0 ($a0)
	move $a1 $s2			# getting the index in $a1
	jal list_obtener
	move $a0 $v0
	jal Pair_fst
	move $v1 $v0
	li $v0 0
	j  tab_buscar_end
	
	tab_buscar_NotFound:
		li $v0 -1
		j tab_buscar_end
	
	tab_buscar_end:
		# Epilogue
		addiu $sp $sp 28
		lw $fp ($sp)
		lw $ra -4($sp)
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $s0 -16($sp)
		lw $s1 -20($sp)
		lw $s2 -24($sp)
		
		jr $ra
	

## --- tab_insertar-- ##
#
# In params:
#	$a0: Address of the hashtable object..
#	$a1: key of the element
#	$a2: element to insert.
#
#
# Out params:
#	$v0: error code 0|-1 for success|failure.
#	$v1: element associated with the key
#
# Method vars: <NONE>
#
# Side Effects: <NONE>
#
# Example:
#
## --- End plan --- ##
tab_insertar:
	# Prologue
	sw $fp 0($sp)
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $a2 -16($sp)
	sw $s0 -20($sp)
	sw $s1 -24($sp)
	sw $s2 -28($sp)
	move $fp $sp
	addiu $sp $sp -32
	
	move $s0 $a0
	move $a0 $a2
	jal Pair								# creating a pair that holds the value that we need.
	bltz $v0 HC_noSuchElement
	move $s2 $v1
	
	lw $a0 -8($fp)
	addiu $a0 $a0 4		# $a0 now holds the position of the header.
	lw $a0 ($a0)			# we load the pointer to the header.
	jal get_comp_hash			
	sw $v0 PairComp		# we set PairComp for when we need to do the search on the list.
	
	
	lw $a0 -8($fp)
	lw $a1 -12($fp)
	
	lw $a0 -8($fp)			# $a0 holds again the address of the hashtable
	addiu $a0 $a0 4		# and now the address of the header.
	lw $a0 ($a0)			# and now a pointer to the header.
	jal get_hash_hash		# we get the position of the array that we need to look for.
	move $a0 $a1			# now it holds the key
	jalr $v0					# we hash it.
	lw $a0 -8($fp)			# now $a0 holds the hashtable address again
	addiu $a0 $a0 8		# we move it so it points to the pointer of the contents.
	lw $a0 ($a0)			# we de-reference it and get the pointer.
	mul $v0 $v0 4			# converting to words
	addu $a0 $a0 $v0		# positioning ourselves in the list.
	lw $a0 ($a0)			# we de-reference the pointer in order to go to the list.
	move $a1 $s2			# loading the element to insert.
	jal list_insertar
	bltz $v0 tab_insertar_error
	li $v0 0
	j tab_insertar_end
	
	tab_insertar_error:
		li $v0 -1
	
	tab_insertar_end:
		# Epilogue
		addiu $sp $sp 32
		lw $fp 0($sp)
		lw $ra -4($sp)
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $a2 -16($sp)
		lw $s0 -20($sp)
		lw $s1 -24($sp)
		lw $s2 -28($sp)
		
		jr $ra
		
## --- tab_destruir-- ##
#
# In params:
#	$a0: Address of the hashtable object.
#
#
# Out params: <NONE>
#
# Method vars: <NONE>
#
# Side Effects: 
#	The hashTable is destroyed
#
# Example:
#
## --- End plan --- ##
tab_destruir:
	# Prologue
	sw $fp 0($sp)
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $a2 -16($sp)
	sw $s0 -20($sp)
	sw $s1 -24($sp)
	sw $s2 -28($sp)
	move $fp $sp
	addiu $sp $sp -32
	
	lw $a0 4($a0)		# loading the pointer to the head like structure.
	jal get_number_part_hash
	move $s0 $v0		# saving the number of partitions.
	
	# now we proceed to destroy it. 
	lw $a0 ($a0)
	li $a1 0
	sw $a1 ($a0)	# erasing the address field
	sw $a1 4($a0)	# erasing the comp field
	sw $a1 8($a0)	# erasing  the hash field
	sw $a1 12($a0)	# erasing the partition field
	sw $a1 16($a0) # erasing the print field
	
	
	lw $a0 -8($fp)		# loading the address again
	sw $a1 4($a0)		# werasing the pointer to the head.
	lw $a0 8($a0)		# stepping into the strucutre.
	move $s1 $a0
	
	
	tab_destruir_loop: 
		beqz $s0 tab_destruir_end
		lw $a0 ($a0) 
		jal list_destruir
		li $a0 0
		sw $a0 ($s1) 
		addiu $s1 $s1 4
		move $a0 $s1
		addi $s0 $s0 -1
		j tab_destruir_loop
	
	tab_destruir_end:
		lw $a0 -8($fp)		# loading the address again
		sw $s0 8($a0)
		# Epilogue
		addiu $sp $sp 32
		lw $fp 0($sp)
		lw $ra -4($sp)
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $a2 -16($sp)
		lw $s0 -20($sp)
		lw $s1 -24($sp)
		lw $s2 -28($sp)
		
		jr $ra
		
		
tab_rehash:
	# Prologue
	sw $fp 0($sp)
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $a2 -16($sp)
	sw $s0 -20($sp)
	sw $s1 -24($sp)
	sw $s2 -28($sp)
	sw $s3 -32($sp)
	sw $s4 -36($sp)
	sw $s5 -40($sp)
	move $fp $sp
	addiu $sp $sp -44
	
	
	move $s0 $a0		# $s0 holds the old hashtable
	move $s1 $a1		# $s1 holds the new partitions.
	addi $a0 $a0 4
	lw $a0 ($a0)		# now $a0 holds the head.
	
	jal get_comp_hash
	move $a1 $v0		# $a1 holds the new compare function.
	
	jal get_hash_hash
	move $a2 $v0		# $a2 holds the new hash function.
	
	jal get_number_part_hash
	
	move $s3 $v0		# now $s3 holds the old partitions.
	
	move $a0 $s1		# now $a0 holds the new partitions
	
	blt $a0 $s3 tab_rehash_error
	
	jal tab_crear
	
	move $s2 $v1		# $s2 holds the address of the new table.
	
	lw $a0 -8($fp)		# $a0 points to the old hashtable
	
	addi $a0 $a0 8
	lw $a0 ($a0)		# now $a0 points to it's contents.
	
	move $s4 $a0
	
	move $s5 $s2		# $s5 stores the new hashtable address
	addiu $s2 $s2 8
	lw $s2 ($s2)		# now $s2 points to the contents of the new hashtable.
	li $a1 0
	
	tab_rehash_array_loop:
		beqz $s3	tab_rehash_end
		lw $a0 ($s4)		# $a0 now points to the list.
		sw $a0 ($s2)		# $s2 now holds the list.
		sw $a1 ($s4)		# we erase the list from the old Hashtable
		addiu $s4 $s4 4
		addiu $s2 $s2 4
		addi $s3 $s3 -1
		j tab_rehash_array_loop
	
	tab_rehash_error:
		li $v0 -5
		li $v1 0
		j tab_rehash_error_end
	
	tab_rehash_end:
		lw $a0 -8($fp)
		jal tab_destruir
		li $v0 0
		lw $a0 -8($fp)
		sw $s5 ($a0)
		addi $a1 $s5 4
		lw $a1 ($s5)
		sw $a1 4($a0)
		addi $a1 $s5 8
		lw $a1 ($s5)
		sw $a1 8($a0)
		tab_rehash_error_end:
		# Epilogue
		addiu $sp $sp 44
		lw $fp 0($sp)
		lw $ra -4($sp)
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $a2 -16($sp)
		lw $s0 -20($sp)
		lw $s1 -24($sp)
		lw $s2 -28($sp)
		lw $s3 -32($sp)
		lw $s4 -36($sp)
		lw $s5 -40($sp)
		
		jr $ra
	
	
	
	
	
	
	
