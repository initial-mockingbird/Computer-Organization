## --- Plan matriz_obtener --- ##
#
# In params:
#	$a0: Matrix Header Address
#	$a1: Row to insert
#	$a2: Col to insert
#
# Out params: <NONE>
#
# Method vars: <NONE>
#
# Side Effects: 
#	The character in $a3 is inserted in the matrix at MAT[$a1][$a2]
#
# Example:
#
## --- End plan --- ##

.text
matriz_obtener:
	#Prologue
	sw	$fp, 0($sp)
	move	$fp, $sp
	addi	$sp, $sp, -4
	
	lw	$t0, 4($a0)	# We load matrix row
	lw	$t1, 8($a0)	# We load matrix col
	addiu	$t2, $a0, 16	# We get matrix data address
	
	mul	$t3, $t1, $a1
	addu	$t3, $t3, $a2
	addu	$t2, $t2, $t3
	
	lb 	$v0, 0($t2)
	
	#Epilogue
	move	$sp, $fp
	lw	$fp, 0($fp)
	
	jr	$ra
