.data

# --- General use vars --- #
transmitter_control: .word 0xffff0008	
reciever_control: .word 0xffff0000
transmitter_data: .word 0xffff000c
reciever_data: .word 0xffff0004
V:	.word 
N: .word 20
M: .word 5
S: .word 5
manzana: .word 0x40		# "@"
cuerpo: .word 0x2A		# "*"
cabeza: .word 0x4F		# "O"
pared: .word 0x23			# "#"
coord_manzana: .word
puntaje: .word 0
siguiente: .word 5	
aux: .word
snek: .word 
# --- Script vars --- # 

# Keyboard_event script vars:

prev_movement: .word


.globl transmitter_control, reciever_control, transmitter_data,reciever_data, N,M,manzana,cuerpo,cabeza,pared,coord_manzana,puntaje,
.globl siguiente, S, aux

.globl prev_movement
