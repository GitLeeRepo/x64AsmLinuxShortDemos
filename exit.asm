; Executes the exit system call
; assemble with: yasm -f elf64 -gdwarf2 -l exit.lst exit.asm
; link with: ld -o exit exit.o
; note: if this had defined a main proc rather than _start "gcc -o exit exit.o" 
;       could have been used to both assemble and link the program
;
; Enter "echo $?" immediately after executing "./exit" to see the status code

    segment  .text
    global   _start

_start:
    mov   eax,1   ; the exit syscall number
    mov   ebx,5   ; the status code to return (code in least sig byte of eax)
    int   0x80    ; the system call

