.include "linux.s"
.equ Stack_Error_Code, 8
.equ Stack_Error_MSG, 12
.globl error_exit, @function

error_exit:
	pushl %ebp
	movl %esp, %ebp

	movl Stack_Error_Code(%ebp), %ecx
	pushl %ecx
	call count_chars
	popl %ecx
	movl %eax, %edx
	movl $STDERR, %ebx
	movl $Sys_Write, %eax
	int $Linux_Syscall

	movl Stack_Error_MSG(%ebp), %ecx
	pushl %ecx
	call count_chars
	popl %ecx
	movl %eax, %edx
	movl $STDERR, %ebx
	movl $Sys_Write, %eax
	int $Linux_Syscall

	movl $Sys_Exit, %eax
	movl $1, %ebx
	int $Linux_Syscall
	
