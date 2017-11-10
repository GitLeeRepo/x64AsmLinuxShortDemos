; logical.asm
; Takes a command line arguement to determine whether to perform an AND, 
; OR, or XOR operation on the specified binary numbers.  No arguement or
; an invlid arguement will display instructions on running.
;
; Uses printf from the runtime library
;
; Note: Due to the printf format string not displaying binary numbers, these
; numbers for the result are hard coded, however, the decimal number equivellent
; that is displayed is not hard code but calculate using the bitwise (AND, OR, 
; and XOR) instructions
;
; Compile with: yasm -f elf64 -g dwarf2 -l logical.lst logical.asm
; Link with: gcc -static -o logical logical.o


        segment .data
; printf format string
format1 db      "%s and %d decimal", 0x0a, 0
; help message
msg1    db      "Command line args (a, o, or x)", 0x0a
        db      "Given a = 0101b and b= 1001b:", 0x0a
        db      "Use a for AND operation, o for OR operaton, and x for XOR "
        db      "operation on command line", 0x0a, 0
; info message
msg2    db      "Given a = 0101 binary and 5 decimal", 0x0a 
        db      "and   b = 1001 binary and 9 decimal:", 0x0a, 0

; part of result string
andStr  db      "    AND = 0001 binary",0
orStr   db      "     OR = 1101 binary",0
xorStr  db      "    XOR = 1100 binary",0

; demo numbers used for binary operations
a       db      0x05    ; binary 0101
b       db      0x09    ; binary 1001

        segment .text
        global  main
        extern  printf

main:
        push    rbp
        mov     rbp,rsp
        sub     rsp,16              ; local stack to save current ecx before changed by print
        mov     rcx,rsi             ; ptr to agv, which in turn is an array of ptrs
        add     rcx,8               ; Skip the first arguement (the program name)
        mov     rsi,[rcx]           ; ptr to the 1st arg in array to print
        cmp     rsi,0               ; Check to see if there are no arguements provided
        jz      help                ; if they are NOT provided jump to help

        xor     rdx,rdx             ; zero before using in logical operations
        mov     rax,[rsi]           ; the command line arg to check
chk_and:
        cmp     al,0x61             ; is it ascii 'a' (for AND operation)?
        jne     chk_or              ; if NOT jump to to OR check
        mov     dl,[a]              ; load the first binary number (edx/dl used in printf)
        and     dl,[b]              ; perform AND operation with second binary number
        lea     rsi,[andStr]        ; load the ptr to the AND result string for printf
        jmp     print  

chk_or:        
        cmp     al,0x6f             ; is it ascii 'o' (for OR operation)?
        jne     chk_xor             ; if NOT jump to XOR check
        mov     dl,[a]              ; load the first binary number (edx/dl used in printf)
        or      dl,[b]              ; perform OR operation with the second binary number
        lea     rsi,[orStr]         ; load the ptr to the OR result string for printf
        jmp     print

chk_xor: 
        cmp     al,0x78             ; is it ascii 'x' (for XOR operation)?
        jne     help                ; if NOT jump to help, invalid arguement
        mov     dl,[a]              ; load the first binary number (edx/dl used in printf)
        or      dl,[b]              ; perform XOR operation with the second binary number
        lea     rsi,[xorStr]        ; load the ptr to the XOR resut string for printf

print:
        call    DisplayInfo
        lea     rdi,[format1]       ; format string for printf
        xor     eax,eax
        call    printf              ; rdi = format str, rsi = ptr to str arg, edx = result num
        xor     rax,rax             ; rc = 0
        jmp     end

help:   call    DisplayHelp
        mov     rax,0x0f            ; rc = 15

end:
        leave
        ret

; Display help message when no or invalid args provided
DisplayHelp:
        push rcx                    ; save those regs changed here, including by printf
        push rdi
        push rsi
        lea rdi, [msg1]
        xor eax,eax
        call printf
        pop rsi
        pop rdi
        pop rcx
        ret

; Display header info when successfully run
DisplayInfo:
        push rcx                    ; save those regs changed here, including by printf
        push rdx
        push rdi
        push rsi
        lea rdi, [msg2]
        xor eax,eax
        call printf
        pop rsi
        pop rdi
        pop rdx
        pop rcx
        ret


