#FUNCION LIST_CREAR
#
#PARAMETROS DE ENTRADA
#$a0:	Direccion de la funcion de comparacion
#$a1:	Direccion de la funcio de Impresion
#
#PARAMETROS DE SALIDA
#$v0:	-1 si hubo error en la ejecucion y 0 si la ejecucion fue exitosa
#$v1:	Direccion de la lista

#USO DE REGISTROS INTERNOS
#$t0:	Se guarda la direccion inicial del header temporalmente y la funcion de comparacion

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
	move	$t0, $a0 # We temporaly store comparison method address to allocate memory
	
	li	$v0, 9 # We allocate list HEADER space
	li	$a0, 16
	syscall
	
	move	$v1, $v0 # We store list address in return register
	
	# Chequea si la direccion que devolvio es valida
	# Preguntar a eduardo
	beqz	$v0, mem_unavailable
	
	sw	$v0, 0($v0) # We store HEADER address
	sw	$t0, 4($v0) # We store list comparison method
	sw	$a1, 8($v0) # We store list print method
	
	li	$t0, 0xffffffff
	sw	$t0, 12($v0) # We define HEADER next element as NIL

	li	$v0, 0
	jr	$ra
	
	
mem_unavailable:
	li	$v0, -1
	jr	$ra
