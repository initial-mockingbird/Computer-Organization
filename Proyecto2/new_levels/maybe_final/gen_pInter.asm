
#$a0 DIR HEADER MATRIZ
gen_pInter:
	sw	$fp, 0($sp)
	move	$fp, $sp
	sw	$ra, -4($sp)
	sw	$s0, -8($sp)
	sw	$s1, -12($sp)
	sw	$s2, -16($sp)
	sw	$s3, -20($sp)
	sw	$s4, -24($sp)
	sw	$s5, -28($sp)
	sw	$s6, -32($sp)
	addiu	$sp, $sp, -36
	
	lw	$s0, N
	lw	$s1, M
	addi	$s0, $s0, -2	# N - 1
	addi	$s1, $s1, -2	# M - 1
	addi	$s2, $zero, 1	# 1
	move	$s6, $a0	# Guardamos el HEADER de la matriz
	
	mul	$s5, $s1, $s0	# Area total del mapa vacia
	div	$s5, $s5, 10	# Bloques a llenar

	
pInter_loop:
	beqz	$s5, exit_pInter	# Salte cuando ya se hayan generado el 10% enteros
	j	look_freeBlock
	
	
look_freeBlock:
	move	$a1, $s0
	li	$v0, 42		# Random de [0,N-1]
	syscall
	
	move	$s3, $a0	# Guardamos la pos Y generada
	addi	$s3, $s3, 1
	
	move	$a1, $s1	# Random de [0,M-1]
	syscall	
	
	move	$s4, $a0	# Guardamos la pos X generada
	addi	$s4, $s4, 1
	
	
check_bloqueVacio:
	move	$a0, $s6
	move	$a1, $s3
	move	$a2, $s4
	
	jal	matriz_obtener
	
	bnez	$v0, look_freeBlock
	
	
check_xFrente:
	beq	$s4, 6, sudandofrio_y
	
	
sudandofrio_y:
	beq	$s3, 5, look_freeBlock
	move	$a0, $s6
	move	$a1, $s3
	move	$a2, $s4
	li	$a3, 0x23
	
	jal	matrix_insert
	
	move	$a0, $s3
	move	$a2, $s4
	li	$a2, 0x23
	jal 	display
		
	addi	$s5, $s5, -1
	j	pInter_loop
	
	
exit_pInter:
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, -4($sp)
	lw	$s0, -8($sp)
	lw	$s1, -12($sp)
	lw	$s2, -16($sp)
	lw	$s3, -20($sp)
	lw	$s4, -24($sp)
	lw	$s5, -28($sp)
	lw	$s6, -32($sp)

	jr	$ra