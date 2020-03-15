## --- Plan snek_crear --- ##
#
# In Params:
#	$a0: Snek MAX SIZE
#
# Out Params:
#	$v0: Snek HEADER address
#
# Method Variables:
#	$t0: 
#	
# Side Effects
#	
#
## --- End Plan --- ##

#DESCRIPCION LISTA
# PRIMERO LLEVA UNA CABEZA QUE CONTIENE:
#
#	~Direccion header
#	~TAmano
#	~Direccion cola/ultimo elemento
#

.text

list_crear:
	# EPILOGUE
	sw	$fp, 0($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -4
	
	li	$v0, 9 # We allocate list HEADER space
	li	$a0, 16
	syscall
	
	sw	$v0, 0($v0) # We store HEADER address
	sw	$zero, 4($v0) # We store list size
	li	$t0, 0xffffffff
	sw	$t0, 8($v0) # We store list TAIL/LAST ELEMENT dir
	sw	$t0, 12($v0) # We define HEADER next element as NIL dir

	j	list_crear_exit
	

list_crear_exit:
	# PROLOGUE
	move	$sp, $fp
	lw	$fp, 0($fp)
	jr	$ra
