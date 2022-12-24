	.intel_syntax noprefix                  # set syntax to intel

	.section .text                          # instruction section
	.global L_FRAG             	        # make starting label available to the linker
L_FRAG:
	mov r8b, BYTE PTR [rbx]                 # stores command type argument
	mov r9, QWORD PTR [rbx + 7]             # stores address of head node
        call CHECK_ARG_FRAG                     # calls conditional code to determine which fragment to call
						# the address of the appropriate subrotine is left in r11
l_loop_next:
	cmp r9, 0				# check if r9 == 0 (null address, end of list)
	je l_loop_done				# if equal, terminate
	mov rbx, r9				# move address of node value to rbx (arg for sum.s)
	call r11				# call fragment determined by CHECK_ARG_FRAG
	mov r9, QWORD PTR [r9 + 8]              # move address of next node into r9
	jmp l_loop_next				# jump to code that handles next node
l_loop_done:
	ret
	
