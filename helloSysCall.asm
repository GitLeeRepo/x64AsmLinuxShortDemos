; hello2.asm
; This version of Hello World uses interupt 0x80 rather than printf
; as was used in hello.asm.  This version doesn't use a main proc,
; using the _start label instead.  It is linked with ld instead of 
; gcc, and is not linked with the standard c lib.
;
; Assemble with: yasm -f elf64 -d dwarf2 -l hello2.lst hello2.asm
; Link with: ld -o hello2 hello2.o


global _start

section .text
_start:
	mov	eax, 4 ; write
	mov	ebx, 1 ; stdout
	mov	ecx, msg
	mov	edx, msg.len
	int	0x80   ; write(stdout, msg, strlen(msg));

	mov	eax, 1 ; exit
	mov	ebx, 0
	int	0x80   ; exit(0)

section .data
msg:	db	"Hello, world!", 10
.len:	equ	$ - msg
