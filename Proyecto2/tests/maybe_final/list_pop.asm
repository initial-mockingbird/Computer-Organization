
#$a0 es la dir de la lista

# $t0 es la direccion al antepenultimo
# $t1 es un auxiliar
# $t2 es el tamano de la lista

# Hay que hacer caso vacio/plus caso solo uno

.text

list_pop:
	# PROLOGUE
	sw	$fp, 0($sp)
	move	$fp, $sp
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	
	# If the list is already empty, do nothing
	lw	$t2, 4($a0)
	beqz	$t2, list_pop_exit
	
	lw	$t0, 8($a0)	# We load list last element address
	lw	$t0, 8($t0)	# We load list last element previous address
	
	# We set (previous to last).next element to NIL/-1
	li	$t1, -1
	sw	$t1, 12($t0)
	
	
update_tail:
	# We update list size
	
	addi	$t2, $t2, -1
	sw	$t2, 4($a0)
	
	beqz	$t2, is_empty 	# We check if the list is empty after the pop
	
	sw	$t0, 8($a0)	# We change HEADER tail to new last 
				# If list is empty, the previous was HEADER and next coincides with first
	j 	list_pop_exit	# that is set to -1 because the header is the previous to last element!
	
	
is_empty:
	# In case list is empty, we update list tail to NIL/-1
	addi	$t2, $t2, -1
	sw	$t2, 8($a0)
	
	
list_pop_exit:
	# EPILOGUE
	lw	$ra, 4($sp)
	move	$sp, $fp
	lw	$fp, 0($sp)
	
	jr	$ra
	
