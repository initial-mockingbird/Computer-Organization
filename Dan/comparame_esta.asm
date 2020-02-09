comparar:
	beq $a0 $a1 equal
	blt $a0 $a1 less
     	li $v0 1
     	jr $ra
equal:
     li $v0 0
     jr $ra
less:
     li $v0 -1
     jr $ra