	.intel_syntax noprefix	# set syntax to intel
	.section .text		# instructions section
	.global AND_FRAG	# make starting label for subroutine available to andtest.s
AND_FRAG:			# starting label
	and rax, QWORD PTR [rbx]	# x = x bitwise and y
	add rbx, 8			# rbx += 8
	ret				# return to where the routine was called from
