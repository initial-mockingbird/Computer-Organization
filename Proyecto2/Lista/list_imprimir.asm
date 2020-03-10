## --- Plan list_imprimir --- ##
#
# In Params:
#	$a0: List address (Header address)
#
# Out Params:
#	$v0: Operation ending code (-1 faulty execution/0 successfull execution)
#
# Method Variables:
#	$t0: Element print method
#	$t1: Element to print
#
# Side Effects: <NONE>
#
## --- End Plan --- ##

list_imprimir:
	# PROLOGUE
	sw	$fp, 0($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -8
	sw	$ra, 4($sp)
	
	lw	$t0, 8($a0)	# Loads element print method
	lw	$a0, 12($a0)	# Load first element (we should check emptiness first)
	beq	$a0, 0xffffffff, exit_imprimir
	j	imprimir_elementos
	
	
imprimir_elementos:

	# ERROR NUESTRO! LOS MOVE A $S4 NO ESTABA. EL PROBLEMA RADICA EN QUE
	# LA DIRECCION DE LA LISTA ESTA GUARDADA EN EL REGISTRO $a0 Y ESTE SE
	# USA PARA CARGAR LA DIRECCION HACIA EL ELEMENTO PERO NUNCA SE RESTAURA
	# DE VUELTA LA DIRECCION DE LA LISTA EN $A0.
	
	move	$s4, $a0
	
	lw	$a0, 4($a0)	# We load list element value address
	
	# STORE DATA JUST IN CASE
	addi	$sp, $sp, -8
	sw	$t0, 8($sp)	# We store element print method
	sw	$a0, 4($sp)	# We store current list element address
	
	jalr	$t0	# We print the element	

	# LOAD DATA
	lw	$t0, 8($sp)
	lw	$a0, 4($sp)
	addi	$sp, $sp, 8
	
	move	$a0, $s4	# PARTE DEL ERROR
	
	lw	$a0, 12($a0)	# We load next element address
	
	beq	$a0, 0xffffffff, exit_imprimir	# If address is NIL bye bye
	j	imprimir_elementos
	

exit_imprimir:
	# EPILOGUE
	lw	$ra, 4($sp)
	move	$sp, $fp
	lw	$fp, 0($sp)
	
	li	$v0, 1
	jr	$ra
