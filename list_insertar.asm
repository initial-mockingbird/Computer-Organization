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
# Method variables:
#	$t0: Comparison method for the elements
#	$t1: Previous element
	
list_insertar:
	
	move	$t1, $a0 # First we copy the header address
	lw	$t0, 4($a0) # We store the list element comparison method

	lw	$a0, 12($a0) # We load the next position address
	beq	$a0, 0xffffffff, last_element # Checks if the list if empty
	j	compare_loop
	

# En a0 tengo la direccion del elemento actual always
	
compare_loop:
	# PROLOGUE
	addiu	$sp, $sp, -20
	sw	$ra, 20($sp)
	sw	$a0, 16($sp)
	sw	$a1, 12($sp)
	sw	$t0, 8($sp)
	sw	$t1, 4($sp)
	
	lw	$a0, 4($a0) # We load current list element value
	jalr	$t0 # We compare $a0 and $a1 (current list and element to insert)
	
	# EPILOGUE
	lw	$ra, 20($sp)
	lw	$a0, 16($sp)
	lw	$a1, 12($sp)
	lw	$t0, 8($sp)
	lw	$t1, 4($sp)
	addiu	$sp, $sp, 20

	bgez	$v0, insert_here # If to_insert <= current_element
	
	move	$t1, $a0
	lw	$a0, 12($a0) # We load next element address
	beq	$a0, 0xffffffff, last_element # If there is no next element, add
	j	compare_loop
		
insert_here:
	move	$t3, $a0 # Temporal storage
	
	li	$v0, 9 # We allocate new element memory
	li	$a0, 16
	syscall
	
	move	$a0, $t3 # We restore from temporal storage (dont do this)
	
	sw	$v0, 12($t1) # The previous next goest to new element
	
	sw	$v0, 0($v0)
	sw	$a1, 4($v0)
	sw	$t1, 8($v0) # The new prev goes to the previous
	sw	$a0, 12($v0) # The new next goest to current element
	
	sw	$v0, 8($a0) # The current previous goes to new
	
	li	$v0, 0
	jr	$ra 
	
	
last_element:
	li	$v0, 9
	li	$a0, 16
	syscall
	
	sw	$v0, 0($v0) # The
	sw	$a1, 4($v0) # The new value
	sw	$t1, 8($v0) # The next previous goes to the previous
	li	$a0, 0xffffffff
	sw	$a0, 12($v0) # The new next goes to NIL
	
	sw	$v0, 12($t1) # The previous next goes to new element
	
	li	$v0, 0
	jr	$ra

	
.include "list_crear.asm"
#.include "list_longitud.asm"
.include "list_obtener.asm"
.include "list_imprimir.asm"
.include "comparame_esta.asm"
