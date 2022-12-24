	.intel_syntax noprefix			# set syntax to intel
	
	.section .data				# data section
	.global SUM_POSITIVE			# make SUM_POSITIVE available to sum.s
	.global SUM_NEGATIVE			# make SUM_NEGATIVE available to sum.s
SUM_POSITIVE:					# label to store sum of positive values (8 bytes)
	.quad 0x0
SUM_NEGATIVE:					# label to store sum of negatve values (8 bytes)
	.quad 0x0
OUTPUT_VAL:					# label for value of rax before writing to sdout
	.quad 0x0

	.section .text				# instruction section
	.global _start				# make _start available to linker
_start:	
	xor rax, rax				# zero out rax
	xor rsi, rsi				# zero out rsi
	mov rbx, OFFSET CALC_DATA_BEGIN		# move the start address of data to rbx 
loop_next:					# label for the loop to continue
	mov sil, BYTE PTR [rbx]			# move first byte to sil (first byte of rsi) to avoid extra memory access
	cmp sil, 0				# check if the first byte of the instruction is 0
	je loop_done				# if equal, jump to end label
	cmp sil, '&				# check if the first byte is '&' (and)
	je handle_and				# if equal, jump to code that handles and
	cmp sil, '|		                # check if the first byte is '|' (or)
	je handle_or                            # if equal, jump to code that handles or
	cmp sil, 'S				# check if the first byte is 'S' (sum)
	je handle_sum				# if equal, jump to code that handles sum
	cmp sil, 'U				# check if the first byte is 'U' (upper)
	je handle_upper				# if equal, jump to code that handles upper
	cmp sil, 'a				# check if the first byte is 'a' (arraysum)
	je handle_sumarray			# if equal, jump to code that handles arraysum
	cmp sil, 'l				# check if the first byte is 'l' (listsum)
	je handle_sumlist			# if equal, jump to code that handles listsum
	cmp sil, 'A				# check if the first byte is 'A' (array)
	je handle_array				# if equal, jump to code that handles array
	cmp sil, 'L				# check if the first byte is 'L' (list)
	je handle_list				# if equal, jump to code that handles list
	cmp sil, 'I'				# check if the first bute is 'I' (ATOQ)
	je handle_atoq				# if equal, jump to code that handles ATOQ
	jmp loop_next				# jump to next iteration of loop

handle_and:
	add rbx, 8                              # advance by 8 bytes to argument position
	call AND_FRAG				# call and subroutine
	jmp loop_next				# jump to next iteration of loop
handle_or:
	add rbx, 8                              # advance by 8 bytes to argument position
	call OR_FRAG                       	# call or subroutine
	jmp loop_next                           # jump to next iteration of loop
handle_sum:
	add rbx, 8				# advance by 8 bytes to argument position
	call SUM_FRAG				# call sum subroutine
	jmp loop_next                           # jump to next iteration of loop
handle_upper:
	add rbx, 8				# advance by 8 bytes to argument position
	call UPPER_FRAG				# call upper.s start label
	jmp loop_next				# jump to next iteration of the loop
handle_sumarray:
	add rbx, 8                              # advance by 8 bytes to argument position
	push rbx                                # save value of rbx on the stack (overwritten by arraysum.s)
	call ARRSUM_FRAG                        # call arraysum.s start label
	pop rbx                                 # restore value of rbx
	add rbx, 16                             # advance rbx to skip two 8-byte args
	jmp loop_next                           # jump to next iteration of the loop
handle_sumlist:
	add rbx, 8				# advance by 8 bytes to argument position
	push rbx				# save value of rbx on the stack (overwritten by listsum.s)
	call LSUM_FRAG				# call listsum.s start label
	pop rbx					# restore value of rbx
	add rbx, 8				# advance rbx to skip arg
	jmp loop_next				# jump to next iteration of the loop
handle_array:
	push rbx				# save value of rbx on the stack
	inc rbx					# advance by one byte to command type argument
	call ARR_FRAG				# call array.s start label
	pop rbx                                 # restore value of rbx
	add rbx, 24                             # advance rbx to skip three 8-byte args
	jmp loop_next                           # jump to next iteration of the loop
handle_list:
        push rbx                                # save value of rbx on the stack
	inc rbx                                 # advance by one byte to command type argument
	call L_FRAG	                        # call list.s start label
	pop rbx                                 # restore value of rbx
	add rbx, 16                             # advance rbx to skip two 8-byte args
        jmp loop_next                           # jump to next iteration of the loop
handle_atoq:
	add rbx, 8				# advance by 8 bytes to argument position
	push rbx				# save value of rbx on the stack (overwritten by atoq.s)
	call ATOQ_FRAG				# call atoq.s start label
	pop rbx					# restore value of rbx
	add rbx, 8				# advance rbx to skip arg
	jmp loop_next				# jump to next iteration of the loop
loop_done:					# loop end label
	mov QWORD PTR [OUTPUT_VAL], rax		# store rax at memory location for writing
	mov rax, 1				# place write syscall number in rax
	mov rdi, 1				# place file descriptor number in rdi
	mov rsi, OFFSET OUTPUT_VAL		# place address of final rax value memory loc. in rsi
	mov rdx, 8				# place number of bytes to write in rdx
	syscall					# system call to write final rax value
	
	mov rax, 1                              # place write syscall number in rax
	mov rdi, 1                              # place file descriptor number in rdi
	mov rsi, OFFSET SUM_POSITIVE            # place address of SUM_POSITIVE in rsi
	mov rdx, 8                              # place number of bytes to write in rdx
	syscall                                 # system call to write SUM_POSITIVE

	mov rax, 1                              # place write syscall number in rax
        mov rdi, 1                              # place file descriptor number in rdi
        mov rsi, OFFSET SUM_NEGATIVE            # place address of SUM_NEGATIVE in rsi
        mov rdx, 8                              # place number of bytes to write in rdx
        syscall                                 # system call to write SUM_NEGATIVE

	mov rax, 1                              # place write syscall number in rax
	mov rdi, 1                              # place file descriptor number in rdi
	mov rsi, OFFSET CALC_DATA_BEGIN         # place address of CALC_DATA_BEGIN in rsi	
	mov rbx, OFFSET CALC_DATA_END		# place address of CALC_DATA_BEGIN in rbx
	sub rbx, OFFSET CALC_DATA_BEGIN		# rbx = rbx - address of CALC_DATA_END
	mov rdx, rbx			 	# place number of bytes between CALC_DATA_END and CALC_DATA_BEGIN in rdx 
	syscall					# system call to write memory between CALC_DATA_BEGIN and CALC_DATA_END
	
	mov rax, 60				# place exit syscall number in rax
	mov rdi, 0				# place exit code in rdi
	syscall					# exit syscall
