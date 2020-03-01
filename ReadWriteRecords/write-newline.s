.include "linux.s"
.globl write_newline
.type write_newline, @function

.section .data
newline:
	.ascii "\n"
	.section .text
	.equ Stack_File_Des,8

write_newline:
	pushl %ebp
	movl %esp, %ebp

	movl $Sys_Write, %eax
	movl Stack_File_Des(%ebp), %ebx
	movl $newline, %ecx
	movl $1, %edx
	int $Linux_Syscall
	movl %ebp, %esp
	popl %ebp
	ret
