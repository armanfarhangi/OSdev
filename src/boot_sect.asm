; BIOS automatically places boot sector binary at 0x7c00
; org makes sure that label addresses are automatically offset appropriately
[org 0x7c00]

; equ keyword results in preprocessed constants rather than constants in memory
KERNEL_LOAD_ADDRESS equ 0x1000

; set stack pointers far away from boot sector address
; if stack base is too close, then it will overwrite our boot sector binary!
; this is because the stack grows downward in memory
mov bp, 0x9000
mov sp, bp

mov bx, REAL_MODE_MSG
call print_string
call print_nl

mov bx, KERNEL_LOAD_MSG
call print_string
call print_nl
call print_nl

; ds:bx is where disk data will be loaded into memory
; ds:bx is ds address * 16 + bx address
mov bx, KERNEL_LOAD_ADDRESS
; amount of sectors we want to read
; will later be compared to how many actually read
mov dh, 2
call read_disk

call switch_pm ; calls init_pm which calls CODE_SEG:start_pm

%include "16bit/constants.asm"
%include "16bit/functions/print_string.asm"
%include "16bit/functions/print_nl.asm"
%include "16bit/functions/read_disk.asm"
%include "16bit/functions/switch_pm.asm"
%include "32bit/constants/gdt.asm"
%include "32bit/functions/init_pm.asm"
%include "32bit/constants/strings.asm"
%include "32bit/functions/print_string_pm.asm"

; 32bit protected mode
[bits 32]
start_pm:

    mov ebx, GREETING3
    call print_string_pm

    ; infinite loop
    jmp $

; defines 510 zero-bytes minus the size of previous code
; $ represents the address at start of current line
; $$ represents the address at start of section
times 510 - ($-$$) db 0

; special value that tells BIOS this is the boot sector
dw 0xaa55
