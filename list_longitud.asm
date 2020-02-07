## --- Plan list_longitud --- ##
#
# In Params:
#	$a0: List address (Header address)
#
# Out Params:
#	$v0: List len (element number)
#
# Method Variables: <NONE>
#
# Side Effects: <NONE>
#
## --- End Plan --- ##

list_longitud: # Header entry
	li	$v0, 0 	# Set counter to 0
	lw	$a0, 8($a0) # Load next element address
	bne	$a0, 0xffffffff, iterate_list # If it isn't NIL, iterate
	jr	$ra
	
	
iterate_list:
	addi	$v0, $v0, 1 # Count 1 element
	lw	$a0, 12($a0)
	bne	$a0, 0xffffffff, iterate_list
	jr	$ra
