        .intel_syntax noprefix                  # set syntax to intel

	.section .text				# instruction section
	.global ARRSUM_FRAG			# make starting label available to the linker
ARRSUM_FRAG:
	mov r8, QWORD PTR [rbx] 		# stores length argument
	mov r9, QWORD PTR [rbx + 8]		# stores address of the array label
	xor r10, r10 				# stores index into array
	# loop through array while calling SUM_FRAG for each element
as_loop_next:
	cmp r10, r8				# check if index == length
	je as_loop_done				# if equal, terminate
	imul rbx, r10, 8			# rbx = r10 * 8 (index * num. bytes of each elem.)
	add rbx, r9				# place address of ith element into rbx (arg for sum.s)
	call SUM_FRAG				# call sum.s
	inc r10					# increment index
	jmp as_loop_next			# jump to next element

as_loop_done:
	ret
