.data

# --- General use vars --- #
transmitter_control: .word 0xffff0008	
reciever_control: .word 0xffff0000
transmitter_data: .word 0xffff000c
reciever_data: .word 0xffff0004
V:	.word 500
#N: .word 12
#M: .word 117
N: .word 10
M: .word 15
S: .word 20	
manzana: .word 0x40		# "@"
cuerpo: .word 0x2A		# "*"
cabeza: .word 0x4F		# "O"
pared: .word 0x23			# "#"
coord_manzana: .space 8
coord_cabeza:  .space 8
puntaje: .word 0
snek: .word 0
map: .word 0
timer: .word 0
pasadizo: .word 0
prox: .word 3
next_movement: .word 0
dificultad: .word 0
# --- Script vars --- # 

# Keyboard_event script vars:

prev_movement: .word 0

# Ingame Messages:

__loose_: .asciiz "Has muerto :C"


.globl transmitter_control, reciever_control, transmitter_data,reciever_data, N,M,manzana,cuerpo,cabeza,pared,coord_manzana,puntaje
.globl  S, V, coord_cabeza, w_movement, a_movement, s_movement, d_movement, snek,map, timer

.globl prev_movement


.text

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
	#addi $a0 $a0 -1
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
	#addi $a0 $a0 1
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
