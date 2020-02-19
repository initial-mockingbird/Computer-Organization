.data
tryHash: .word 0

.text



li $a0 5
la $a1 hashF
la $a2 comparar
li $a3 0
jal tab_crear
sw $v1 tryHash
li $t0 5


hashF: 
	mult $a0 $a1 
	li $a1 5
	rem $v0 $a0 $a1
	jr $ra 
	
.include "comparame_esta.asm" 
.include "HashTable.asm"