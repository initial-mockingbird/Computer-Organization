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
	# Pedimos la memoria para el HEADER
	li	$v0, 9
	# Se guarda la direccion de la funcion de comparacion
	move	$t0, $a0
	li	$a0, 12
	syscall
	
	# Se guarda la direccion de la lista
	move	$v1, $v0
	
	# Chequea si la direccion que devolvio es valida
	beqz	$v0, mem_unavailable
	
	# Creando el Header (Funciones)
	sw	$t0, 0($v0)
	sw	$a1, 4($v0)
	
	li	$t0, 0xffffffff
	sw	$t0, 8($v0)

	# Se guarda la direccion de memoria del header para no borrarla y poder agregar
	# la direccion al siguiente elemento
	#move	$t0, $v0
	
	# Pedimos el espacio para el siguiente elemento
	#li	$v0, 9
	#li	$a0, 16
	#syscall
	
	# Se agrega al HEADER la direccion del primer elemento
	#sw	$v0, 8($t0)
	
	# Terminamos con codigo de error 0 (exitoso)
	li	$v0, 0
	jr	$ra
	
	
mem_unavailable:
	li	$v0, -1
	jr	$ra
