; Takes the a & b legs of a right triangle, squares each and adds them together,
; then compares the result to the hypotenous squared to see if it is valid.
; If it is a valid match return zero in the rax register, otherwise return 1.
; Check the result with ./pythag ; $? which will print the return value
;
; Compile with: yasm -f elf64 -g dwarf2 pythag.asm
; Link with: gcc -static -o pythag pythag.o

    segment .data
a   dq      246           ; a leg of right triangle
b   dq      328           ; b leg of right triangle
c   dq      410           ; the hypotenous to check if valid

    segment .text
    global  main 
main:
    mov rax,[a]             ; load a value
    imul rax,rax            ; and square it
    mov rbx,[b]             ; load 'b' value
    imul rbx,rbx            ; and square it
    mov rcx,[c]             ; load 'c' value
    imul rcx,rcx            ; and square it
    add rax,rbx             ; add 'a' and 'b'
    sub rax,rcx             ; if match they will be the same
    jz match                ; if zero they are a match, zero is returned
    mov rax,1               ; no match, 1 is returned
match:    
    ret
