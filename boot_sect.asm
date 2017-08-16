; set to tty mode, which is necessary to write to screen
mov ah, 0x0e
; set character and raise interrupt to write
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10

; infinite loop
jmp $

; defines 510 zero-bytes minus the size of previous code
; $ is a constant for address at start of current line
; $$ is a constant for address at start of previous line
times 510 - ($-$$) db 0

; special value that tells BIOS this is the boot sector
dw 0xaa55
