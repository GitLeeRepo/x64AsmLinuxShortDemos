    segment .data
a   dd      4
b   dd      4.4
c   db      0xff
d   times   10 dd 0
e   dw      0xffff
f   dd      0xffffffff
g   db      "Hello, World!", 0xa, 0

    segment .bss
h   resd    1
i   resd    10
j   resb    100

    segment .text
    global main
main:
    push    rbp
    mov     rbp,rsp
    sub     rsp, 16
    leave
    ret

