.include "linux.s"
.include "record_def.s"

.equ Stack_Write_Buffer, 8
.equ Stack_Filedes, 12

.section .text
.globl write_record
.type write_record, @function

write_record:
	pushl %ebp
	movl %esp, %ebp

	pushl %ebx
	movl Stack_Filedes(%ebp), %ebx
	movl Stack_Write_Buffer(%ebp), %ecx
	movl $Record_Size, %edx
	movl $Sys_Write, %eax
	int $Linux_Syscall

	popl %ebx
	movl %ebp, %esp
	pop %ebp
	ret
