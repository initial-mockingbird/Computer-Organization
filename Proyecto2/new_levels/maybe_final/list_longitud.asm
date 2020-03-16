## --- Plan list_longitud --- ##
#
# In Params:
#	$a0: List address (HEADER address)
#
# Out Params:
#	$v0: List len (element number)
#
# Method Variables: <NONE>
#
# Side Effects: <NONE>
#
## --- End Plan --- ##

list_longitud: # HEADER entry/Empty check
	# EPILOGUE
	sw	$fp, 0($sp)
	move	$fp, $sp
	addi	$sp, $sp, -4
	
	li	$v0, 0 	# Set counter to 0
	lw	$a0, 12($a0) # Load next element address
	bne	$a0, 0xffffffff, iterate_list # If it isn't NIL, iterate
	j	list_long_exit
	
	
iterate_list:
	addi	$v0, $v0, 1
	lw	$a0, 12($a0)
	bne	$a0, 0xffffffff, iterate_list
	j	list_long_exit


list_long_exit:
	# PROLOGUE
	move	$sp, $fp
	lw	$fp, 0($sp)
	jr	$ra
