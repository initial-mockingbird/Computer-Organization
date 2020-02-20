## --- Plan list_longitud --- ##
#
# In Params:
#	$a0: List address (Header address)
#	$a1: Index of element to return
#
# Out Params:
#	$v0: Address of the element at the index
#	$v1: Operation ending code (-1 faulty execution/0 successfull execution)
#
# Method Variables: <NONE>
#	$a0: Current element address
#	$v0: Length of the list (just at the start)
#	$a1: Counter
#	
# Side Effects: <NONE>
#
## --- End Plan --- ##

list_obtener:
	# PROLOGOUE
	sw	$fp, 0($sp)
	move	$fp, $sp
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	
	blt	$a1, 1, error # 1 <= Index

	# STORING DATA JUST IN CASE
	addi	$sp, $sp, -8
	sw	$a0, 8($sp)
	sw	$a1, 4($sp)
	
	jal 	list_longitud	# We calculate list length
	
	# RESTORING DATA
	lw	$a0, 8($sp)
	lw	$a1, 4($sp)
	addi	$sp, $sp, 8
	
	bgt	$a1, $v0, error # Index <= Length
	
	lw	$a0, 12($a0)	# We load the first element address into $a0
	
	
search_iteration: # Iterate trough the list looking for the element
	addi	$a1, $a1, -1	# We decrease the counter
	beqz	$a1, obtain_element
	lw	$a0, 12($a0)	# We load the next element address
	
	j	search_iteration
	
	
obtain_element:	# Return the element at the requested index
	lw	$v0, 4($a0)
	li	$v1, 0
	j	list_obtain_exit
	

list_obtain_exit:
	# EPILOGUE
	lw	$ra, 4($sp)
	move	$sp, $fp
	lw	$fp, 0($fp)
	
	jr	$ra
	
error: # Index out of bound case
	li	$v1, -1
	j	list_obtain_exit
