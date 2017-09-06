; BIOS automatically places boot sector binary at 0x7c00
; org makes sure that label addresses are automatically offset appropriately
[org 0x7c00]

; set stack pointers far away from boot sector address
; if stack base is too close, then it will overwrite our boot sector binary!
; this is because the stack grows downward in memory
mov bp, 0x8000
mov sp, bp

mov bx, GREETING1
call print_string

call print_nl

mov bx, GREETING2
call print_string

; infinite loop
jmp $

; file inclusions
%include "constants.asm"
%include "print_string.asm"
%include "print_nl.asm"

; defines 510 zero-bytes minus the size of previous code
; $ represents the address at start of current line
; $$ represents the address at start of section
times 510 - ($-$$) db 0

; special value that tells BIOS this is the boot sector
dw 0xaa55
