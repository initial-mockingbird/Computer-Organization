.data
tryHash: .word 0
table:	.word 0
.text



li $a0 5
la $a1 hashF
la $a2 comparar
li $a3 0
jal tab_crear

sw $v1 table
move $a0 $v1
li $a1 1
li $a2 1
jal tab_insertar

lw $a0 table
li $a1 2
li $a2 2
jal tab_insertar

lw $a0 table
li $a1 4
li $a2 4
jal tab_insertar

lw $a0 table
li $a1 3
li $a2 3
jal tab_insertar

hashF: 
	move $v0 $a0
	jr $ra 
	
.include "comparame_esta.asm" 
.include "HashTable.asm"
.include "pair.asm"
