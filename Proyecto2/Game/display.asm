## --- Plan display --- ##
#
# In params:
#	$a0: x pos
#	$a1: y pos
#	$a2: Character to insert
#
# Out params: <NONE>
#
# Method vars: <NONE>
#
# Side Effects: 
#	The character in $a2 is printed on the screen, at cursor position ($a0,$a1)
#
# Example:
#
## --- End plan --- ##




display:
	# prologue
	sw $fp 0($sp)
	sw $ra -4($sp)
	sw $s0 -8($sp)
	sw $s1 -12($sp)
	sw $a0 -16($sp)
	sw $a1 -20($sp)
	sw $a2 -24($sp)
	move $fp $sp
	addiu $sp $sp -28
	
	
	
	move $s0 $a0
	move $s1 $a1
	
	disp_set_pos:
	
	#sll $a0 $a0 12
	#or $a0 $a0 $a1
	#sll $a2 $a2 8
	#ori $a2 $a2 0x7
	
	sll $a1 $a1 20
	sll $a0 $a0 8
	or $a1 $a1 $a0
	li $a0 0x7
	or $a1 $a1 $a0
	
	
	lw $a0 transmitter_control
	lw $a0 ($a0)
	beqz $a0 disp_set_pos
	nop
	lw $a0 transmitter_data
	sw $a1 ($a0)
	
	print_char:
	
	lw $a0 transmitter_control
	lw $a0 ($a0)
	beqz $a0 print_char
	nop
	lw $a0 transmitter_data
	sw $a2 ($a0)
	
	#epilogue
	addiu $sp $sp 28
	lw $fp 0($sp)
	lw $ra -4($sp)
	lw $s0 -8($sp)
	lw $s1 -12($sp)
	lw $a0 -16($sp)
	lw $a1 -20($sp)
	lw $a2 -24($sp)
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
