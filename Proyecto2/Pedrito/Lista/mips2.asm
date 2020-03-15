.text

	jal	list_crear
	
	move	$a0, $v0
	move	$t6, $v0
	li	$a1, 10
	jal	list_push
	
	move	$a0, $t6
	li	$a1, 11
	jal 	list_push
	
	move	$a0, $t6
	li	$a1, 1
	jal 	list_obtener
	
	move	$a0, $t6
	jal	list_pop
	move	$a0, $t6
	jal	list_pop
	
	li	$v0, 10
	syscall

.include "list_crear.asm"
.include "list_insertar.asm"
.include "list_destruir.asm"
.include "list_longitud.asm"
.include "list_obtener.asm"
.include "list_pop.asm"
