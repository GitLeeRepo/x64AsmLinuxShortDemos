; cmdlargs.asm
; Enter any number of arguements on the commandline to this program and it will repeat
; them back, one line at a time
;
; Uses printf from the runtime library
;
; Compile with: yasm -f elf64 -g dwarf2 -l cmdlargs.lst cmdlargs.asm
; Link with: gcc -static -o cmdlargs cmdlargs.o


        segment .data
format  db      "%s", 0x0a, 0

        segment .text
        global  main
        extern  printf

main:
        push    rbp
        mov     rbp,rsp
        sub     rsp,16              ; local stack to save current ecx before changed by print
        mov     rcx,rsi             ; ptr to agv, which in turn is an array of ptrs
        mov     rsi,[rcx]           ; ptr to the 1st arg in array to print
start_loop:
        lea     rdi,[format]        ; format string for printf
        mov     [rsp],rcx           ; put argv ptr on local stack to save it
        call    printf              ; rdi has format str, rsi has ptr to current arg
        mov     rcx,[rsp]           ; restore saved argv ptr to rcx due to printf changing it
        add     rcx,8               ; now increment it to the offset of the next arg
        mov     rsi,[rcx]           ; The next arg to print
        cmp     rsi,0               ; unless its a null, in which case loop ends
        jnz     start_loop
end_loop:
        xor     eax,eax
        leave
        ret
