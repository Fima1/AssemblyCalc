	.intel_syntax noprefix  # set syntax to intel
	.section .text          # instructions section
	.global UPPER_FRAG
UPPER_FRAG:
	xor r8, r8 		# will store length of the string
	xor r10, r10 		# will store index into the string
	mov r11, QWORD PTR [rbx] # move the pointer the string to r11
loop_next:
	mov dl, BYTE PTR [r11 + r10]	# place char at index rsp of string into byte-wide register of rdx
	cmp dl, 0		# compare with zero
	je loop_done		# if char == 0, terminate
	cmp dl, 'a		# compare with 'a'
	jl not_lower		# if ascii less than 'a', jump to not_lower
	cmp dl, 'z		# compare with 'z'
	jg not_lower		# if ascii greater than 'z', jump to not_lower
	sub dl, 32		# subtract 32 from dl to convert from upper to lower ascii
	mov BYTE PTR [r11 + r10], dl # place byte back into memory

not_lower:			# label for handling nonzero non-lowercase-ascii chars (same as continue in loop)
	inc r8			# increment length
	inc r10			# increment index
	jmp loop_next		# jump to next character
loop_done:
	add rax, r8		# add string length to rax
	add rbx, 8		# advance rbx to skip argument 
	ret			# go back to where the subroutine was called from
