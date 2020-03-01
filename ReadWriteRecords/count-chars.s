.type count_chars, @function
.globl count_chars

.equ Stack_Str_Start_Add, 8

count_chars:
	pushl %ebp
	movl %esp, %ebp

	movl $0, %ecx
	movl Stack_Str_Start_Add(%ebp), %edx

	count_loop_begin:
		movb (%edx), %al
		cmpb $0, %al
		je count_loop_end
		incl %ecx
		incl %edx
		jmp count_loop_begin
	count_loop_end:
		movl %ecx, %eax
		popl %ebp
		ret
