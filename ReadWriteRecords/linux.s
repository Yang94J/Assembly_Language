# Common linux Definition

# System Call Numbers

.equ Sys_Exit, 1
.equ Sys_Read, 3
.equ Sys_Write, 4
.equ Sys_Open, 5
.equ Sys_Close, 6
.equ Sys_Brk, 45

#System Call Interrupt Number
.equ Linux_Syscall, 0x80

#Standard File Descriptors

.equ StdIn, 0
.equ StdOut, 1
.equ StdErr, 2

# Common Status Codes
.equ End_Of_File, 0

