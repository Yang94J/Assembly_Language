.include "record_def.s"
.include "linux.s"

.equ Stack_Read_Buffer, 8
.equ Stack_Filedes, 12

.section .text
.globl read_record
.type read_record, @function

read_record:
	pushl %ebp
	movl %esp, %ebp

	pushl %ebx
	movl Stack_Filedes(%ebp), %ebx
	movl Stack_Read_Buffer(%ebp), %ecx
	movl $Record_Size, %edx
	movl $Sys_Read, %eax
	int $Linux_Syscall
	
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
