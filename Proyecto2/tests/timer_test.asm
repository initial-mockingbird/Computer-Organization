
.globl main
.text
main:


inf_loop:

	#jal Generar_manzana
	nop
	nop
	#li $v0 4
	#la $a0 mess
	#syscall
	
	nop
	nop
	
   j inf_loop
   nop
  	j inf_loop
  	nop
  	j inf_loop
	li $v0 10
	syscall

.include "Glob_vars.asm"

