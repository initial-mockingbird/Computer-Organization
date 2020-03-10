##### Double-Linked List Push Function #####
#
# In Params:
#	$a0: List address (Header address)
#	$a1: Element to insert address
#
# Out Params: <NONE>
#
# Side Effects:
#	List located in $a0 address now has element $a1 inserted as its
#	first element
# 
# Method variables:
#	$v0: toInsert NODE address
#	$t1: HEADER address
#	$t2: Previous FIRST address
	
list_push:
	# PROLOGUE
	sw	$fp, 0($sp)
	move	$fp, $sp
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	
	move	$t1, $a0 # First we store the header address

	lw	$t2, 12($a0) # We load the next position address
	j	insert_first
	
	
insert_first:
	li	$v0, 9
	li	$a0, 16
	syscall
	
	sw	$v0, 0($v0) # The list NODE address
	sw	$a1, 4($v0) # The toInsert is inserted in the NODE
	sw	$t1, 8($v0) # The toInsert previus goes to HEADER
	
	beq	$t2, -1, empty_insert
	
	sw	$t2, 12($v0) # The toInsert next goes to the fist element in list 
	
	sw	$v0, 8($t2) # The nextElement previous goes to toInsert NODE address
	
	j	update_first


empty_insert:
	li	$a0, -1
	sw	$a0, 12($v0)	# The toInsert next goes to NIL	
	sw	$v0, 8($t1)	# The header tail goes to first
	
	
update_first:
	sw	$v0, 12($t1)	# THe HEADER first goes to the toInsert node
	# We now update list size
	lw	$a0, 4($t1)
	addi	$a0, $a0, 1
	sw	$a0, 4($t1)
	
	
list_push_exit:
	# EPILOGUE
	lw	$ra, 4($sp)
	move	$sp, $fp
	lw	$fp, 0($sp)
	
	jr	$ra
