.section .data
first_string:
	.ascii "Hello %s is a %s who loves the number %d \n \0"
name:
	.ascii "Hang"
person:
	.ascii "Student"
Numberloved:
	.long 4

.section .text
.globl _start
_start:
	pushl Numberloved
	pushl $person
	pushl $name
	pushl $first_string

	call printf

	pushl $0
	call exit
