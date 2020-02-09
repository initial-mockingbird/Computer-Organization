.data

lista: 		.word 0
header:		.word 0
elemento1: 	.word 0
elemento2: 	.word 0
elemento3:	.word 0
imprimir:	.word 0
.text

main:
	lw $a0 comparar
	lw $a1 imprimir
	jal list_crear

	sw $v0 lista
	
	move $a0 $v0
	li $a1 1
	jal list_insertar
	
	move $a0 $v0
	li $a1 1
	jal list_insertar

	move $a0 $v0
	li $a1 0
	jal list_insertar

	move $a0 $v0
	li $a1 2
	jal list_insertar


.include "lista.asm"
.include "comparame_esta.asm"