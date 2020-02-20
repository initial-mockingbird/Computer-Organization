.data

lista1: 		.word 0
header1:		.word 0
elemento1: 	.word 0
elemento2: 	.word 0
elemento3:	.word 0
imprimir:	.word 50
.text

main:

	la $a0 comparar
	la $a1 imprimir
	jal list_crear

	sw $v1 lista1
	
	move $s0 $v1
	
	move $a0 $s0
	li $a1 1
	jal list_insertar
	
	move $a0 $s0
	li $a1 2
	jal list_insertar

	move $a0 $s0
	li $a1 0
	jal list_insertar

	move $a0 $s0
	li $a1 2
	jal list_insertar


.include "lista.asm"
.include "comparame_esta.asm"
