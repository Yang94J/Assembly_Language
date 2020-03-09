.section .data

heap_begin:
	.long 0

current_break:
	.long 0

.equ Header_Size, 8
.equ HDR_AVAIL_Offset, 0
.equ HDR_Size_Offset,4

.equ Unavailable, 0
.equ Available,1
.equ Sys_Brk, 45
.equ Linux_Syscall, 0x80

.section .text

.globl allocate_init
.type allocate_init, @function
allocate_init:
	pushl %ebp
	movl %esp, %ebp

	movl $Sys_Brk, %eax
	movl $0, %ebx
	int $Linux_Syscall

	incl %eax
	movl %eax, current_break

	movl %eax, heap_begin
	movl %ebp, %esp
	popl %ebp
	ret

.globl allocate
.type allocate, @function
.equ Stack_Memory_Size, 8
allocate:
	pushl %ebp
	movl %esp, %ebp
	movl Stack_Memory_Size(%ebp), %ecx
	movl heap_begin, %eax
	movl current_break, %ebx

	allocate_loop_begin:
		cmpl %ebx, %eax
		je move_break

	movl HDR_Size_Offset(%eax), %edx
	cmpl $Unavailable, HDR_Avail_Offset(%eax)
	je next_location

	cmpl %edx, %ecx
	jle allocate_here

	next_location:
		addl $Header_Size, %eax
		addl %edx, %eax

	jmp alloc_loop_begin

	allocate_here:
		movl $Unavailable, HDR_Avail_Offset(%eax)
		addl $Header_Size, %eax
		movl %ebp, %esp
		popl %ebp
		ret

	move_break:
		addl $Header_Size, %ebx
		addl %ecx, %ebx
		pushl %eax
		pushl %ecx
		pushl %ebx
		movl $Sys_Brk, %eax
		int $Linux_Syscall

		cmpl $0, %eax
		je error

		popl %ebx
		popl %ecx
		popl %eax

		movl $Unavailable, HDR_Avail_Offset(%eax)
		movl %ecx, HDR_Size_Offset(%eax)

		addl $Header_SIze, %eax
		movl %ebx, current_break
		movl %ebp, %esp
		popl %ebp
		ret

	error:
		movl $0, %eax
		movl %ebp, %esp
		popl %ebp
		ret



.globl deallocate
.type deallocate, @function
.equ Stack_Memory_Seg, 4

deallocate:
	movl Stack_Memory_Seg(%esp), %eax
	subl $Header_Size, %eax
	movl $Available, HDR_Avail_Offset(%eax)

	ret
