## --- Plan snek_obtener --- ##
#
# In Params:
#	$a0: SNEK HEADER address
#	$a1: Pos to insert
#	$a2: Element to insert in snek
#
# Out Params: <NONE>
#
# Method Variables:
#
# Side Effects:
#	Element $a2 is inserted at SNEK[$a1]
#
## --- End Plan --- ##

snek_insertar:
	#PROLOGO
	sw	$fp, 0($sp)
	sw	$ra, -4($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -8
	
	# We get base position (HEADER ADDRESS + 3 WORDS)
	addiu	$a0, $a0, 12
	mul	$a1, $a1, 4	# We get the base offset
	addu	$a0, $a0, $a1	# BASE + OFFSET 
	
	sw	$a2, 0($a0)	# We insert $a2 in the BASE + OFFSET
	
	#EPILOGO
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, -4($sp)
	
	jr	$ra