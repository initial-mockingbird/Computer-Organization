##### Double-Linked List Insert Function #####
#
# In Params:
#	$a0: List address (Header address)
#	$a1: Element to insert address
#
# Out Params:
#	$v0: Operation ending code (-1 faulty execution/0 successfull execution)
#
# Side Effects:
#	List located in $a0 address now has element $a1 inserted as its
#	final element.
# 

#TO PREVIO

main:
	li	$a0, 0x10010fff
	li	$a1, 0x10010ffe
	jal	list_crear
	move	$a0, $v1
	li	$a1, 0x100100fe
	jal	list_insertar
	li	$a1, 0x1001feef
	move	$a0, $v1
	jal 	list_insertar
	li	$a1, 0x1001b16f
	move	$a0, $v1
	jal 	list_insertar
	#move	$a0, $v1
	#li	$a1, 7
	#jal	list_obtener
	move	$a0, $v1
	jal	list_imprimir
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall
	
list_insertar:
	# First we deal with the header
	move	$t0, $a0
	# We load the next position address
	lw	$a0, 8($a0)
	beq	$a0, 0xffffffff, no_elements
	
look_for_last:
	# We store the previous element address
	move	$t0, $a0
	# We get the next element address
	lw	$a0, 12($a0)
	# We check if it is NIL
	beq,	$a0, 0xffffffff, add_element
	# If not, keep iterating in the list
	j	look_for_last
	
add_element:
	# We allocate memory for the next element
	li	$v0, 9
	li	$a0, 16
	syscall
	
	# We store the next element address in the previous element
	sw	$v0, 12($t0)
	
	# From here is in the new element
	# We store the current address of the element
	sw	$v0, 0($v0)
	# We store the element value
	sw	$a1, 4($v0)
	# We store the previous element address
	sw	$t0, 8($v0)
	# We set to NIL the next element address
	li	$t0, 0xffffffff
	sw	$t0, 12($v0)
	jr	$ra
	
no_elements:	# In case the list is empty
	# We allocate memory for the new element
	li 	$v0, 9
	li	$a0, 16
	syscall
	
	# Stores element current address
	sw	$v0, 0($v0)
	# Stores element address 
	sw	$a1, 4($v0)
	# Stores previous element direction
	sw	$t0, 8($v0)
	# We add to the header the address to the first element of the list
	sw	$v0, 8($t0)
	

	# Stores next element direction
	li	$t0, 0xffffffff
	sw	$t0, 12($v0)
	
	li	$v0, 0
	
	jr	$ra
	
.include "list_crear.asm"
#.include "list_longitud.asm"
.include "list_obtener.asm"
.include "list_imprimir.asm"