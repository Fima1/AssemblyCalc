	.intel_syntax noprefix	# set syntax to intel
	
	.section .text		# instructions section
	.global SUM_FRAG 	# make start label for the subroutine available to sumtest.s
SUM_FRAG:			# start label for the subroutine
	mov rcx, QWORD PTR [rbx]	# store y in rcx (resolves add issue)
	cmp rcx, 0			# check if y is negative
	jl s_negative			# if y negative, jump to code that ads to SUM_NEGATIVE
	add QWORD PTR [SUM_POSITIVE], rcx	# add y to SUM_POSITIVE
	jmp sum_done				# skip negative section
s_negative:				# label for handling negative numbers
	add QWORD PTR [SUM_NEGATIVE], rcx	# add y to SUM_NEGATIVE
sum_done:			# finishing code label
	add rax, rcx		# x += y
	add rbx, 8		# rbx += 8
	ret			# return to where the routine was called from
