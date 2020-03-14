## --- Plan list_crear --- ##
#
# In Params: <NONE>
#
# Out Params:
#	$v0: Operation ending code (-1 faulty execution/0 successfull execution)
#	$v1: List address
#
# Method Variables:
#	$t0: Temp HEADER next element address storage/Temp comparison method address storage
#	
# Side Effects
#	An empty list consisting only of its HEADER is created in memory.
#
## --- End Plan --- ##

#DESCRIPCION LISTA
# PRIMERO LLEVA UNA CABEZA QUE CONTIENE:
#
#	~Direccion header
#	~Direccion cola/ultimo elemento
#	~Direccion Primer elemento
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
