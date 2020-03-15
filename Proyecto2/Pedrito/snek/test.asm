
main:
	li	$a0, 4
	jal	create_snek
	
	move	$s0, $v0
	
	move	$a0, $s0
	li	$a1, 1
	
	jal	snek_push
	
	move	$a0, $s0
	li	$a1, 2
	
	jal	snek_push
	
	move	$a0, $s0
	li	$a1, 3
	
	jal	snek_push
	
	move	$a0, $s0
	li	$a1, 4
	
	jal	snek_push
	
	li	$v0, 10
	syscall


#INCLUDES NECESARIOS
.include "create_snek.asm"
.include "snek_push.asm"
.include "snek_obtener.asm"
.include "snek_insertar.asm"