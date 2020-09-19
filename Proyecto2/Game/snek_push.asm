## --- Plan snek_push --- ##
#
# In Params:
#	$a0: SNEK HEADER address
#	$a1: Element to insert address
#
# Out Params: <NONE>
#
# Method Variables:
#	$s0: HEADER address
#	$s1: SNEK last element address iteration (to 0)
#	$s2: $s1 SNEK element
#	$s3: $s1 - 1 SNEK element
#	$s7: Element to insert stored
#	
# Side Effects:
#	Element $a1 is inserted at the start of the SNEK array
#
## --- End Plan --- ##

snek_push:
	#PROLOGO
	sw	$fp, 0($sp)
	sw	$ra, -4($sp)
	sw	$s0, -8($sp)
	sw	$s1, -12($sp)
	sw	$s2, -16($sp)
	sw	$s3, -20($sp)
	sw	$s7, -24($sp)
	move	$fp, $sp
	addiu	$sp, $sp, -28
	
	# hasta 0, ahi paras maldito mmguevo
	lw	$s1, 8($a0)
	
	addi	$s1, $s1, 1
	sw	$s1, 8($a0)
	addi	$s1, $s1, -1
	
	move	$s0, $a0	# We store HEADER address in $s1 because is going to be used multiple times
	move	$s7, $a1	# We store $a1
	
	j snek_swap_push_loop


snek_swap_push_loop:
	beqz	$s1, push_first
	
	move	$a0, $s0
	move	$a1, $s1
	jal	snek_obtener
	
	move	$s2, $v0	# last element
	
	move	$a0, $s0
	move	$a1, $s1
	addiu	$a1, $a1, -1	# prev to last
	jal	snek_obtener
	
	move	$s3, $v0	# prev to last element
	
	move	$a0, $s0	# WE LOAD ADDRESS
	move	$a1, $s1	# last			# 
	move	$a2, $s3	# prev to last into last
	jal	snek_insertar
	
	move	$a0, $s0	# WE LOAD ADDRESS
	move	$a1, $s1
	addiu	$a1, $a1, -1	# prev to last
	move	$a2, $s2	# last into prev to last
	jal	snek_insertar
	
	addi	$s1, $s1, -1
	j	snek_swap_push_loop
	

push_first:
	move	$a0, $s0
	li	$a1, 0
	move	$a2, $s7
	jal	snek_insertar
	
	j	exit_snek_push
	
	
exit_snek_push:
	#EPILOGO
	move	$sp, $fp
	lw	$fp, 0($sp)
	lw	$ra, -4($sp)
	lw	$s0, -8($sp)
	lw	$s1, -12($sp)
	lw	$s2, -16($sp)
	lw	$s3, -20($sp)
	lw	$s7, -24($sp)
		
	jr	$ra
	
#INCLUDES NECESARIOS
#.include "snek_insertar.asm"
	
