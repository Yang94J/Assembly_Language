.include "linux.s"
.include "record-def.s"


.section .data
	input_file_name:
		.ascii "test.dat\0"

	output_file_name:
		.ascii "testout.dat\0"

.section .bss
	.lcomm record_buffer, Record_Size

.equ Stack_Input_Des, -4
.equ Stack_Output_Des, -8

.section .text
.globl _start

_start:

	movl %esp, %ebp
	subl $8, %esp

	movl $Sys_Open, %eax
	movl $input_file_name, %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $Linux_Syscall

	cmpl $0, %eax
	jl continue_processing

	.section .data
	no_open_file_code:
		.ascii "0001: \0"
	no_open_file_Msg:
		.ascii "Can't open input file \0"
	
	.section .text
	pushl $no_open_file_code
	pushl $no_open_file_Msg
	call error_exit

continue_processing:

	movl %eax, Stack_Input_des(%ebp)

	movl $Sys_Open, %eax
	movl $output_file_name, %ebx
	movl $0101, %ecx
	movl $0666, %edx
	int $Linux_Syscall

	movl %eax, Stack_Output_des(%ebp)
	
	loop_begin:
		pushl Stack_Input_Des(%ebp)
		pushl $record_buffer
		call read_record
		addl $8, %esp

		cmpl $Record_Size, %eax
		jne loop_end
		
		incl record_buffer+Record_Age

		pushl Stack_Output_Des(%ebp)
		pushl $record_buffer
		call write_record
		addl $8, %esp

		jmp loop_begin

	loop_end:
		movl $Sys_Exit, %eax
		movl $0, %ebx
		int $Linux_Syscall
