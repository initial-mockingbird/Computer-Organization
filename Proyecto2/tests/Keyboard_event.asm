
keyboard_event:
	# Prologue
	sw $sp ($sp)
	sw $fp -4($sp)
	sw $a0 -8($sp)
	sw $a1 -12($sp)
	move $fp $sp
	addiu $sp $sp -16
	
	lw $a0 reciever_data
	lw $a0 ($a0)				# $a0 holds the key
	
	
	beq $a0 0x70 k_pause
	beq $a0 0x71 k_quits
	beq $a0 0x77 w_action
	beq $a0 0x61 a_action
	beq $a0 0x73 s_action
	beq $a0 0x64 d_action
	j k_end
	
w_action:

	lw $a0  prev_movement
	la $a1  s_movement
	beq $a0 $a1 k_end
	lw $a1 w_movement
	sw $a1 prev_movement
	j k_end

a_action:

	lw $a0  prev_movement
	la $a1  d_movement
	beq $a0 $a1 k_end
	lw $a1 a_movement
	sw $a1 prev_movement
	j k_end


s_acttion:

	lw $a0  prev_movement
	la $a1  w_movement
	beq $a0 $a1 k_end
	lw $a1 s_movement
	sw $a1 prev_movement
	j k_end


d_action:

	lw $a0  prev_movement
	la $a1  a_movement
	beq $a0 $a1 k_end
	lw $a1 d_movement
	sw $a1 prev_movement
	j k_end


k_pause:
	li $a0 0
	mtc0 $a0 $11
	j k_end
	
k_quits:
	li $v0 10
	syscall

k_end:
	# Epilogue
	addiu $sp $sp 16
	lw $sp ($sp)
	lw $fp -4($sp)
	lw $a0 -8($sp)
	lw $a1 -12($sp)
	
	jr $ra
	
	
#### Every single funcion of movement takes a tuple and returns the tuple modified
w_movement:
a_movement:
s_movement:	
d_movement:
