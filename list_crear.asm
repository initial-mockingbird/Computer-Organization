## --- Plan list_crear --- ##
#
# In Params:
#	$a0: List elements comparison method address
#	$a1: List elements print method address
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
#	~Direccion funcion comparacion
#	~Direccion funcion impresion
#	~Direccion Primer elemento
#
# CADA ELEMENTO DE LA LISTA ES UN STRUCT TAL QUE:
#
#	~Direccion actual en memoria
#	~Direccion Valor
#	~Direccion previo
#	~Direccion siguiente
#
list_crear:
	# EPILOGUE
	sw	$fp, 0($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -4
	
	move	$t0, $a0 # We temporaly store comparison method address to allocate memory
	
	li	$v0, 9 # We allocate list HEADER space
	li	$a0, 16
	syscall
	
	move	$v1, $v0 # We store list address in return register
	
	beqz	$v0, mem_unavailable # We check if the returned dir is valid
	
	sw	$v0, 0($v0) # We store HEADER address
	sw	$t0, 4($v0) # We store list comparison method
	sw	$a1, 8($v0) # We store list print method
	
	li	$t0, 0xffffffff
	sw	$t0, 12($v0) # We define HEADER next element as NIL

	li	$v0, 0
	j	list_crear_exit
	

mem_unavailable:
	li	$v0, -1
	j	list_crear_exit


list_crear_exit:
	# PROLOGUE
	move	$sp, $fp
	lw	$fp, 0($fp)
	jr	$ra