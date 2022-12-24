	.intel_syntax noprefix	# set syntax to intel
	.section .text		# instructions section
	.global OR_FRAG		# make starting label for subroutine available to ortest.s
OR_FRAG:			# starting label
	or rax, QWORD PTR [rbx]		# x = x bitwise or y
	add rbx, 8			# rbx += 8
	ret				# return to where the routine was called from
