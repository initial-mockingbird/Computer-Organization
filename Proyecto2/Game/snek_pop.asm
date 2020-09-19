## --- Plan snek_pop --- ##
#
# In Params:
#	$a0: SNEK HEADER address
#
# Out Params:
#	$v0: Last element in SNEK
#
# Method Variables:
#	$s0: HEADER address
#	$s1: SNEK last element
#	
# Side Effects:
#	Last element in SNEK is removed from SNEK.
#
## --- End Plan --- ##

snek_pop:
	#PROLOGO
	sw	$fp, 0($sp)
	sw	$ra, -4($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -8

	lw	$a1, 8($a0)
	beqz	$a1, exit_snek_pop
	
	addi	$a1, $a1, -1	# We get last position ocuppied
	sw	$a1, 8($a0)	# We update last position available
	
	# We get base position (HEADER ADDRESS + 3 WORDS)
	addiu	$a0, $a0, 12
	mul	$a1, $a1, 4	# We get the base offset
	addu	$a0, $a0, $a1	# BASE + OFFSET 

	lw	$v0, 0($a0)
	sw	$zero, 0($a0)	# We insert $a2 in the BASE + OFFSET

exit_snek_pop:
	#EPILOGO
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, -4($sp)
	
	jr	$ra