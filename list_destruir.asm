## --- Plan list_destruir --- ##
#
# In Params:
#	$a0: List address (Header address)
#
# Out Params:
#	$v0: Operation ending code (-1 faulty execution/0 successfull execution)
#
# Method Variables: <NONE>
#
# Side Effects:
#	Sets all the memory blocks allocated for the list to the 0 value.
#
## --- End Plan --- ##

list_destruir:
	# PROLOGUE
	sw	$fp, 0($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -4
	
list_destruir_iter:
	
	
	lw	$t0, 12($a0)
	sw	$zero, 0($a0)
	sw	$zero, 4($a0)
	sw	$zero, 8($a0)
	sw	$zero, 12($a0)
	beq	$t0, 0xffffffff, exit_destruir
	move	$a0, $t0
	j	list_destruir_iter
	
	
exit_destruir:
	# EPILOGUE
	move	$sp, $fp
	lw	$fp, 0($fp)
	
	li	$t0, 0	# We set this values to 0 to prevent any info of the
	li 	$a0, 0  # list from being stored
	li	$v0, 0
	jr	$ra
	
