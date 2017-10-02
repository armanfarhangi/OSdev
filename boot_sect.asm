; BIOS automatically places boot sector binary at 0x7c00
; org makes sure that label addresses are automatically offset appropriately
[org 0x7c00]

; set stack pointers far away from boot sector address
; if stack base is too close, then it will overwrite our boot sector binary!
; this is because the stack grows downward in memory
mov bp, 0x8000
mov sp, bp

mov dx, GREETING1
call print_string

call print_nl

mov dx, GREETING2
call print_string

; es:bx is where disk data will be loaded into memory
; es:bx is es address * 16 + bx address
mov bx, 0x9000
; amount of sectors we want to read
; will later be compared to how many actually read
mov dh, 2
call read_disk

; infinite loop
jmp $

; file inclusions
%include "constants/strings.asm"
%include "constants/numbers.asm"
%include "functions/print/print_string.asm"
%include "functions/print/print_nl.asm"
%include "functions/disk/read_disk.asm"

; defines 510 zero-bytes minus the size of previous code
; $ represents the address at start of current line
; $$ represents the address at start of section
times 510 - ($-$$) db 0

; special value that tells BIOS this is the boot sector
dw 0xaa55

; second sector (b/c data immediately follows 512th byte)
db 'This sentence didn't make it in the first 512 bytes (boot sector); it was loaded after', 0
