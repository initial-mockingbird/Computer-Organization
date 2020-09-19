.data

# --- General use vars --- #

# -- MMIO Devices -- ##
transmitter_control: .word 0xffff0008	
reciever_control: .word 0xffff0000
transmitter_data: .word 0xffff000c
reciever_data: .word 0xffff0004
.globl transmitter_control,reciever_control, transmitter_data, reciever_data
# -- Game Options -- ##
V:	.word 250			# Snek Velocity
N: .word 20				# Number of rows in the map.
M: .word 20				# Number of columns in the map.
S: .word 20				# FPS, not currently implemented.
puntaje: .word 0		# Total score.
prox: .word 3			# Score needed in order to get to the next level.
.globl V,N,M,S,puntaje,prox

# -- Game Graphics -- # 
manzana: .word 0x40		# "@"
cabeza: .word 0x4F		# "O"
cuerpo: .word 0x2A		# "*"
pared: .word 0x23			# "#"
.globl manzana,cabeza,cuerpo,pared

# --- Script vars --- # 

coord_manzana: .space 8
coord_cabeza:  .space 8

snek: .word 0					# Holds the snek.
									#FREE THE SNEK 
map: .word 0					# Twitter prison.
timer: .word 0
pasadizo: .word 0				
next_movement: .word 0
prev_movement: .word 0
dificultad: .word 0			# Twitter boolean diversifier.
.globl coord_manzana, coord_cabeza, snek, map, timer, pasadizo, next_movement, prev_movement, dificultad

# Ingame Messages:

__loose_: .asciiz "Has muerto :C"
.globl __loose_



.text


## --- Plan movement w/a/s/d --- ##
#
# In Params:
#	$a0: x position of the snek (row)
#	$a1: y position of the snek (column)
#
# Out Params: <NONE>
#
# Method Variables: <NONE>
#	
# Side Effects:
#	Pasadizo is set to 1 if a pasadizo is crossed.
#
#
## --- End Plan --- ##

a_movement:
	#prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4

	move $v0 $a0
	addi $v1 $a1 -1
	
	# taking the modulus, and considering it could be negative, we apply:
	# ((a%m) + m) %m due to the fact that m%m=0. and (a%m)+m > 0.
	lw $a0 M
	rem $v1 $v1 $a0
	add $v1 $v1 $a0
	rem $v1 $v1 $a0
	
	
	lw $a0 M
	bne $v1 $a0  a_end
	li $a0 1
	sw $a0 pasadizo
	
	 
	 a_end:
	 #epilogue
	addi $sp $sp 4
	lw $fp -4($sp)
	jr $ra

d_movement:
	#prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	move $v0 $a0
	addi $v1 $a1 1
	
	# taking the modulus, and considering it could be negative, we apply:
	# ((a%m) + m) %m due to the fact that m%m=0. and (a%m)+m > 0.
	lw $a0 M
	#addi $a0 $a0 1
	rem $v1 $v1 $a0
	add $v1 $v1 $a0
	rem $v1 $v1 $a0
	
	
	li $a0 0
	bne $v1 $a0  d_end
	li $a0 1
	sw $a0 pasadizo
	
	d_end:
	#epilogue
	addi $sp $sp 4
	lw $fp -4($sp)
	jr $ra

s_movement:
	#prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	move $v1 $a1
	addi $v0 $a0 1
	
	# taking the modulus, and considering it could be negative, we apply:
	# ((a%n) + n) %n due to the fact that m%m=0. and (a%n)+n > 0.
	lw $a0 N
	#addi $a0 $a0 1
	rem $v0 $v0 $a0
	add $v0 $v0 $a0
	rem $v0 $v0 $a0
	
	li $a0 0
	bne $v0 $a0  s_end
	li $a0 1
	sw $a0 pasadizo
	
	s_end:
	#epilogue
	addi $sp $sp 4
	lw $fp -4($sp)
	jr $ra
	

w_movement:
	#prologue
	sw $fp ($sp)
	move $fp $sp
	addi $sp $sp -4
	
	move $v1 $a1
	addi $v0 $a0 -1
	
	# taking the modulus, and considering it could be negative, we apply:
	# ((a%n) + n) %n due to the fact that m%m=0. and (a%n)+n > 0.
	lw $a0 N
	rem $v0 $v0 $a0
	add $v0 $v0 $a0
	rem $v0 $v0 $a0
	
	lw $a0 N
	bne $v0 $a0  w_end
	li $a0 1
	sw $a0 pasadizo
	
	w_end:
	#epilogue
	addi $sp $sp 4
	lw $fp -4($sp)
	jr $ra
