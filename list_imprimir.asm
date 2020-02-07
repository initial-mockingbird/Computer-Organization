## --- Plan list_imprimir --- ##
#
# In Params:
#	$a0: List address (Header address)
#
# Out Params:
#	$v0: Operation ending code (-1 faulty execution/0 successfull execution)
#
# Method Variables: <NONE>
#	$t0: Element print method
#	$t1: Element to print
#
# Side Effects: <NONE>
#
## --- End Plan --- ##

list_imprimir:
	lw	$t0, 8($a0)	# Loads element print method
	lw	$a0, 12($a0)	# Load first element (we should check emptiness first)
	
imprimir_elementos:

	# PROLOGUE
	addiu	$sp, $sp, -8
	sw	$t0, 8($sp)	# We store element print method
	sw	$a0, 4($sp)	# We store current list element address
	
	lw	$a0, 4($a0)	# We load list element value address
	
	jalr	$t0	# We print the element
	
	# EPILOGUE
	lw	$t0, 8($sp)	
	lw	$a0, 4($sp)
	addiu	$sp, $sp, 8
	
	lw	$a0, 12($a0)	# We load next element address
	
	beq	$a0, 0xffffffff, exit	# If address is NIL bye bye
	j	imprimir_elementos
	

exit:
	li	$v0, 1
	jr	$ra