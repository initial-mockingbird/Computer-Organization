Generar_manzana:
	# Prologue 
	sw $fp ($sp)
	sw $ra -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	sw $a2 -16($sp)
	sw $v0 -20($sp)
	sw $v1 -24($sp)
	move $fp $sp
	addiu $sp $sp -28

# --- Generando coordenadas --- #
	#--x--#
	li $v0 42
	lw $a1 N
	syscall
	move $v1 $a0
	move $a2 $v1
	
	#--y--#
	li $v0 42
	lw $a1 M
	syscall
	move $a3 $a0
# --- Generando el par (x,y) --- #
	move $a0 $v1
	move $a1 $v0
	jal Pair
	
# --- Verificacion de si choca con alguna pared --- #
	nop
	
# --- Cargando la coordenada en la etiqueta de la manzana correspondiente --- #
	la $a0 coord_manzana
	sw $v1 ($a0)
	
# --- Impresion en el mapa --- #
	manzana_set_pos:
		
		
		# we set the position
		sll $a2 $a2 12
		or $a2 $a2 $a3
		sll $a2 $a2 8
		ori $a2 $a2 0x7
		
		lw $a0 transmitter_control
		lw $a0 ($a0)
		beqz $a0 manzana_set_pos
		lw $a0 transmitter_data
		sw $a2 ($a0)
		
	manzana_print_pos:
		lw $a1 manzana
		lw $a0 transmitter_control
		lw $a0 ($a0)
		beqz $a0 manzana_print_pos
		lw $a0 transmitter_data
		sw $a1 ($a0)
	
	# Epilogue
	
	ir_exit:
		# Epilogue
		addiu $sp $sp 28
		lw $fp ($sp)
		lw $ra -4($sp)
		lw $a0 -8($sp)
		lw $a1 -12($sp)
		lw $a2 -16($sp)
		lw $v0 -20($sp)
		lw $v1 -24($sp)
		
		jr $ra	
