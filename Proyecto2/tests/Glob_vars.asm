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
siguiente: .word 5	
snek: .word 
coord_pared_interna: .space 4096
cant_pared_interna: .word
# --- Script vars --- # 

# Keyboard_event script vars:

prev_movement: .word

# Ingame Messages:

__loose_: .asciiz "Has muerto :C"


.globl transmitter_control, reciever_control, transmitter_data,reciever_data, N,M,manzana,cuerpo,cabeza,pared,coord_manzana,puntaje,
.globl siguiente, S, V, coord_cabeza

.globl prev_movement
