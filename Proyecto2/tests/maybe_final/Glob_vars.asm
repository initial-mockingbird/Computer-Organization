.data

# --- General use vars --- #
transmitter_control: .word 0xffff0008	
reciever_control: .word 0xffff0000
transmitter_data: .word 0xffff000c
reciever_data: .word 0xffff0004
V:	.word 2000
N: .word 20
M: .word 5
S: .word 5
manzana: .word 0x40		# "@"
cuerpo: .word 0x2A		# "*"
cabeza: .word 0x4F		# "O"
pared: .word 0x23			# "#"
coord_manzana: .space 8
coord_cabeza:  .space 8
puntaje: .word 0
snek: .word 0
map: .word
timer: .word
# --- Script vars --- # 

# Keyboard_event script vars:

prev_movement: .word

# Ingame Messages:

__loose_: .asciiz "Has muerto :C"


.globl transmitter_control, reciever_control, transmitter_data,reciever_data, N,M,manzana,cuerpo,cabeza,pared,coord_manzana,puntaje
.globl  S, V, coord_cabeza, w_movement, a_movement, s_movement, d_movement, snek,map, timer

.globl prev_movement


.text

w_movement:
	#prologue
	sw $sp ($sp)
	sw $fp -4($fp)
	move $fp $sp
	addi $sp $sp -8
	
	move $v0 $a0
	addi $v1 $a1 -1
	
	 #epilogue
	addi $sp $sp 8
	lw $fp -4($fp)
	jr $ra

s_movement:
	#prologue
	sw $sp ($sp)
	sw $fp -4($fp)
	move $fp $sp
	addi $sp $sp -8
	
	move $v0 $a0
	addi $v1 $a1 1
	
	 #epilogue
	addi $sp $sp 8
	lw $fp -4($fp)
	jr $ra

d_movement:
	#prologue
	sw $sp ($sp)
	sw $fp -4($fp)
	move $fp $sp
	addi $sp $sp -8
	
	move $v1 $a0
	addi $v0 $a0 1
	
	 #epilogue
	addi $sp $sp 8
	lw $fp -4($fp)
	jr $ra
	

a_movement:
	#prologue
	sw $sp ($sp)
	sw $fp -4($fp)
	move $fp $sp
	addi $sp $sp -8
	
	move $v1 $a0
	addi $v0 $a0 -1
	
	 #epilogue
	addi $sp $sp 8
	lw $fp -4($fp)
	jr $ra
