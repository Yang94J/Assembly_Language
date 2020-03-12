.equ Stack_Value, 8
.equ Stack_Buffer, 12

.globl integer2string
.type integer2string, @function
integer2string:
pushl %ebp
movl %esp, %ebp
movl $0, %ecx

movl Stack_Value(%ebp), %eax
movl $10, %edi

conversion_loop:
	movl $0, %edx
	divl %edi
	addl $'0', %edx

	pushl %edx
	incl %ecx
	cmpl $0, %eax
	je end_conversion_loop

	jmp conversion_loop

end_conversion_loop:
	movl Stack_Buffer(%ebp), %edx

copy_reversing_loop:
	popl %eax
	movb %al, (%edx)
	decl %ecx
	incl %edx

	cmpl $0, %ecx
	je end_copy_reversing_loop
	jmp copy_reversing_loop

emd_copy_reversing_loop:
	movb $0, (%edx) 	
	movl %ebp, %esp
	popl %ebp
	
