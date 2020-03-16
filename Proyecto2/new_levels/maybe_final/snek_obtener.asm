## --- Plan snek_obtener --- ##
#
# In Params:
#	$a0: SNEK HEADER address
#	$a1: Element to obtain index from 0 to snek size - 1
#
# Out Params:
#	$v0: Element in snek[$a1]
#
# Method Variables:
#
# Side Effects: <NONE>
#
## --- End Plan --- ##

snek_obtener:
	#PROLOGO
	sw	$fp, 0($sp)
	sw	$ra, -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -16
	
	# We get base position (HEADER ADDRESS + 3 WORDS)
	addiu	$a0, $a0, 12
	mul	$a1, $a1, 4	# We get the base offset
	addu	$a0, $a0, $a1	# BASE + OFFSET 
	lw	$v0, 0($a0)	# We store the resulting address
	
	#EPILOGO
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, -4($sp)
	lw $a0 -8($sp)
	lw $a1 -12($sp)
	
	jr	$ra
