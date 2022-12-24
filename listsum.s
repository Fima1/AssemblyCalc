
	.intel_syntax noprefix                  # set syntax to intel

	.section .text				# instruction section
	.global LSUM_FRAG			# make starting label available to the linker
LSUM_FRAG:
	mov r8, QWORD PTR [rbx]			# store address of the head node in r8
ls_loop_next:
	cmp r8, 0				# check if r8 == 0
	je ls_loop_done				# if equal, terminate
	mov rbx, r8				# move address of first node value to rbx (arg for sum.s)
	call SUM_FRAG				# call sum.s
	mov r8, QWORD PTR [r8 + 8]		# move address of next node into r8
	jmp ls_loop_next			# jump to code that handles next node
ls_loop_done:
	ret
	
