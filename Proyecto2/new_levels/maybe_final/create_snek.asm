## --- Plan snek_crear --- ##
#
# In Params:
#	$a0: Snake size
#
# Out Params:
#	$v0: HEADER address
#
# Method Variables: <NONE>
#	
# Side Effects
#	
#
## --- End Plan --- ##

#DESCRIPCION LISTA
# PRIMERO LLEVA UNA CABEZA QUE CONTIENE:
#
#	~Direccion header
#	~Tamano
#	~Direccion ult pos disponible/cuantos lleva dentro
#
create_snek:
	#PROLOGO
	sw	$fp, 0($sp)
	sw	$ra, -4($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -8
	
	# First we create the HEADER
	# We store $a0 just in case
	sw	$a0, 0($sp)
	addiu	$sp, $sp, -4
	
	jal	create_snekHDR
	
	#Restoring $a0
	addiu	$sp, $sp, 4
	lw	$a0, 0($sp)
	
	# V0 FOR FUCK SAKE
	move	$t0, $v0	# Storing $v0 and $a0 just in case again
	move	$t1, $a0
	
	mul	$a0, $a0, 4	# We calculate numbers of words required for the snake FFS we need arithmetic left shift
	li	$v0, 9		# And we allocate the necessary memory. We consider 0 as empty (no direction in there) 
	syscall
	
	move	$v0, $t0
	
	#EPILOGO
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, -4($sp)
	
	jr	$ra
	
#INCLUDES NECESARIOS EN ALGUN SITIO
.include "create_snekHDR.asm"