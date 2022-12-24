        .intel_syntax noprefix                  # set syntax to intel
	.section .data				# data section
OUTPUT_VAL:
	.quad 0x0				# initialize 8-byte space for output value (used by sum.s)
	
	.section .text                          # instruction section
        .global ATOQ_FRAG                       # make starting label available to the linker
ATOQ_FRAG:
	mov r8, QWORD PTR [rbx] 		# move the reference to the string to r8
	# segment to determine length of the string (loop until encounter a non-digit and non-'-' char)
	xor r9, r9 				# r9 = 0, will store length of the string
at_len_loop_next:
	mov r10b, BYTE PTR [r8 + r9]		# get the ith char of the string
	cmp r10b, '-				# check if char == '-'
	je at_len_valchar			# jump to code that handles a valid char
	cmp r10b, '0				# compare char to ascii for '0'
	jl at_loop_start			# if less, terminate loop (reached an invalid char)
	cmp r10b, '9				# compare char to ascii for '9'
	jg at_loop_start  			# if greater, terminate loop (reached an invalid char)
at_len_valchar:
	inc r9					# i++
	jmp at_len_loop_next			# jump to the next iteration of the loop
	# segment to loop backwards into the string while converting ascii to their number representation
at_loop_start:
	cmp r9, 0				# check if length == 0 (handle null strings)
	je at_done				# if equal, terminate
	xor r10, r10				# r10 = 0, will be used as backwards index
	xor r11, r11				# r11 = 0, will store the output number
at_loop_next:
	cmp r9, r10				# check if r9 == r10 (backwards index == length)
	je at_sum				# if equal, terminate loop
	mov r15, r9				# place r9 in r15 (length)
	sub r15, r10				# r15 -= r10 (length - backwards index)
	dec r15					# r15--, result: r15 = r9 - r10 - 1 (index into the string)
	add r15, r8				# add the address of the string to r15 to get address of byte
	mov r12b, BYTE PTR [r15]		# get ith char from the end of the string
	cmp r12b, '-				# check if char == '-'
	je handle_negative			# jump to code that handles negative sign
	sub r12b, '0				# subtract the ascii value of 0 from char to convert to corresponding number
	jmp raise_power				# jump to code that gets the decimal multiple for digit: 10 ^ r10
ret_raise_power:
	mov r14, r12				# place r12 in r14
	imul r14, r13				# r14 = r12 * r13 = digit * 10 ^ r10 = digit in the correct decimal place
	add r11, r14				# add the converted digit to the output number
	inc r10					# i++
	jmp at_loop_next			# jump to the next iteration of the loop
handle_negative:
	not r11					# flip the bits of r11 to get 1's complement
	inc r11					# r11++ to get 2's complement
	# segment to add the converted value to rax and update SUM_POSITIVE and SUM_NEGATIVE
at_sum:
	mov QWORD PTR [OUTPUT_VAL], r11		# place final value in memory at &OUTPUT_VAL
	mov rbx, OFFSET OUTPUT_VAL		# place address of &OUTPUT_VAL in memory
	call SUM_FRAG				# call sum.s
at_done:
	ret					# return to caller fragment in calc.s

	# segment to raise 10 to the (r10)th power, needed to multiply digit by the right decimal place
	# result -> r13
raise_power:
	mov r13, 1				# r13 = 1, will store the output value
	xor r14, r14				# r14 = 0, will store index
rp_loop_next:	
	cmp r14, r10				# compare r14 with r10
	jg rp_loop_done				# if equal, terminate
	cmp r14, 0				# check if r14 == 0
	je rp_continue				# if equal, continue
	imul r13, 10				# r13 = r13 * 10
rp_continue:	
	inc r14					# r14++
	jmp rp_loop_next			# jump to next iteration of the loop
rp_loop_done:
	jmp ret_raise_power			# jump back to caller address in number conversion loop
