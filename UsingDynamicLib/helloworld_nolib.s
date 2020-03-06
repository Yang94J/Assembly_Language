.include "linux.s"

.section .data
	helloworld:
		.ascii "helloworld\n"
	helloworld_end:
		.equ helloworld_len, helloworld_end-helloworld

.section .text

.globl _start
_start:
	movl $StdOut, %ebx
	movl $helloworld, %ecx
	movl $helloworld_len, %edx
	movl $Sys_Write, %eax
	int $Linux_Syscall

	movl $1, %ebx
	movl $Sys_Exit, %eax
	int $Linux_Syscall
