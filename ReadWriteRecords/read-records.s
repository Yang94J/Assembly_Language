.include "linux.s"
.include "record-def.s"

.section .data
file_name:
	.ascii "test.data\0"
	.section .bss
	.lcomm record_buffer, Record_Size

.section .text
.globl _start

_start:
	.equ Stack_Input_Des,-4
	.equ Stack_Output_Des,-8

	movl %esp, %ebp
	subl $8, %esp
	
	movl %Sys_Open, %eax
	movl $file_name, %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $Linux_Syscall

	movl %eax, Stack_Input_Des(%ebp)

	records_read_loop:
		pushl Stack_Input_Des(%ebp)
		pushl $record_buffer
		call read_record
		addl $8, %esp

		cmpl $Record_Size, %eax
		jne finished_reading
	
		pushl $Record_Firstname+record_buffer
		call $4, %esp
		movl %eax, %edx
		movl Stack_Output_Des(%ebp), %ebx
		movl $Sys_Write, %eax
		movl $Record_Firstname+record_buffer, %ecx
		int $Linux_Syscall
	
		pushl Stack_Output_Des(%ebp)
		call write_newline
		addl $4, %esp

		jmp record_read_loop
	
	finished_reading:
		movl $Sys_Exit, %eax
		movl $0, %ebx
		int $Linux_Syscall

		
