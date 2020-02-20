main:
	la	$a0, comparar
	li	$a1, 0x1001f0f0
	jal	list_crear	
	
	move	$t7, $v1
	move	$a0, $t7
	
	li	$a1, 4
	
	jal	list_insertar

	move	$a0, $t7
	
	li	$a1, 1
	
	jal	list_insertar
	
	move	$a0, $t7
	
	li	$a1, 5
	
	jal	list_insertar
	
	move	$a0, $t7
	
	#jal	list_destruir
	
	li	$v0, 10
	syscall
	
	
.include "TADList.asm"
.include "comparame_esta.asm"
