section .data ;not changed at runtime, const
    userMsg db "Please enter an input: " ; define bytes = give value to a set nunmber of bytes addressed by userMsg in the text section
    lenUserMsg equ $-userMsg ; /*current address ($) - (subtract) the len in bits of userMsg so current position, current address - start of userMsg = number of bits between lenUserMsg address (start) and userMsg address (start)*/
    dispMsg db "You have entered: "
    lenDispMsg equ $-dispMsg

section .bss ; (let or var) can be defined at runtime, allocates memory in the uninitialzed data section
    num resb 5 ; allocate 5 bytes for a random value

section .text ; code for the program
    global_start

_start:
    ;write message
    mov eax, 4 ;type of system call -> sys_write
    mov ebx, 1 ; how to write, 1 -> stdout
    mov ecx, userMsg ; il messagio in data section
    mov edx, lenUserMsg ; len of the message
    int 0x80 ; call the kernel to execute the system call with the params described above

    ;read a message
    mov eax, 3 ;type of system call -> sys_read
    mov ebx, 2 ; how to write, 1 -> stdout
    mov ecx, num ; il messagio from the input sotred in the var in the bss section
    mov edx, 5 ; len of the bytes to store
    int 0x80 ; execute the system call with the params described above

    ;write another message
    mov eax, 4 ;type of system call -> sys_write
    mov ebx, 1 ; how to write, 1 -> stdout
    mov ecx, dispMsg ; il messagio in data section
    mov edx, lenDispMsg ; len of the message
    int 0x80 ; call the kernel to execute the system call with the params described above

    ;write (output) the input received number
    mov eax, 4 ;type of system call -> sys_write
    mov ebx, 1 ; how to write, 1 -> stdout
    mov ecx, num ; il messagio in data section
    mov edx, 5 ; len of the message
    int 0x80 ; call the kernel to execute the system call with the params described above

    ;sys call to exit
    mov eax, 1
    mov ebx, 0 ; exit status (0)
    int 0x80
/*
nasm -f elf64 -o sysCall.o  sysCall.nasm
linker: ld sysCall.o -o sysCall
./sysCall
*/

