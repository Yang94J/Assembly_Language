.include "linux.s"
.include "record_def.s"
.section .data

record1:
	.ascii "yanghang\0"
	.rept 31
	.byte 0
	.endr

	.ascii "JamesHarden\0"
	.rept 29
	.byte 0
	.endr

	.ascii "4242 S idwa\0"
	.rept 228
	.byte 0
	.endr

	.long 29


record2:
	.ascii "Mary\0"
	.rept 35
	.byte 0
	.endr

	.ascii "Brown\0"
	.rept 34
	.byte 0
	.endr

	.ascii "zh-cn Peking\0"
	.rept 227
	.byte 0
	.endr

	.long 19

record3:
	.ascii "Tim\0"
	.rept 36
	.byte 0
	.endr

	.ascii "Yangyiyong\0"
	.rept 29
	.byte 0
	.endr

	.ascii "ribenren Tokoyo\0"
	.rept 224
	.byte 0
	.endr

	.long 28

file_name:
	.ascii "testdat\0"

	.equ Stack_File_Des, -4
	.globl _start

_start:
	movl %esp, %ebp
	subl $4, %esp
	subl $Sys_Open, %eax
	movl $file_name, %ebx
	movl $0101, %ecx
	movl $0666, %edx
	int $Linux_Syscall

	movl %eax, Stack_File_Des(%ebp)
	pushl Stack_File_Des(%ebp) 
	pushl $record1
	call write_record
	addl $8, %esp

	pushl Stack_File_Des(%ebp)
	pushl $record2
	call write_record
	addl $8, %esp

	pushl Stack_File_Des(%ebp)
	pushl $record3
	call write_record
	addl $8, %esp

	movl $Sys_Close, %eax
	movl Stack_File_Des(%ebp),%ebx
	int $Linux_Syscall

	movl $Sys_Exit, %eax
	movl $88, %ebx
	int $Linux_Syscall



