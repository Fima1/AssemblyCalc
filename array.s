        .intel_syntax noprefix                  # set syntax to intel
	
        .section .text                          # instruction section
        .global ARR_FRAG                     	# make starting label available to the linker
	.global CHECK_ARG_FRAG			# make conditional start label visible to linker (used by list.s)
CHECK_ARG_FRAG:	
	# conditional to figure out what type of command to call
	# r11 will store the address of the fragment to jump to
	# command type letter -> r8b, leaves address in r11
	cmp r8b, 'S				# check if type == 'S' (sum)
	jne check_or				# if not equal, jump to next check (skip move)
	mov r11, OFFSET SUM_FRAG		# if equal, move address of SUM_FRAG to r11
check_or:					
	cmp r8b, '|				# check if type == '|' (or)
	jne check_and				# if not equal, jump to next check (skip move)
	mov r11, OFFSET OR_FRAG			# if equal, move address of OR_FRAG to r11
check_and:	
	cmp r8b, '&				# check if type == '&' (and)
	jne check_upper				# if not equal, jump to next check (skip move)
	mov r11, OFFSET AND_FRAG		# if equal, move address of AND_FRAG to r11
check_upper:	
	cmp r8b, 'U				# check if type == 'U' (upper)
	jne check_done				# if not equal, jump to next check (skip move)
	mov r11, OFFSET UPPER_FRAG		# if equal, move address of UPPER_FRAG to r11
check_done:
	ret

	# loop to process all values of the array
ARR_FRAG:
	mov r8b, BYTE PTR [rbx]                 # stores command type argument
	mov r9, QWORD PTR [rbx + 7]             # stores length argument
        mov r10, QWORD PTR [rbx + 15]           # stores address of the array label
	call CHECK_ARG_FRAG			# calls conditional code to determine which fragment to call
	xor r12, r12				# set r12 to 0 - will store the index into the array
a_loop_next:
	cmp r12, r9				# check if index == length
	je a_loop_done				# if equal, terminate
	imul rbx, r12, 8			# rbx = index * 8
	add rbx, r10				# rbx += array start label (rbx = r10 + r12 * 8)
	call r11				# call the instruction address of the appropriate subroutine
	inc r12					# index++
	jmp a_loop_next				# jump to next iteration of the loop
a_loop_done:
	ret
