; in 32bit mode, we have to create our own driver in order to print to screen
; there's a Video Graphics Array (VGA) that starts at 0xb8000
; as we write to the array, text is displayed on the screen

; address to null-terminated string is in ebx
; increment by two bytes; one for character and one for text characteristics
; first two bytes will print a character at top-left of screen

[bits 32]
; constants relevant to 32bit mode printing
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je print_string_pm_end

    mov [edx], ax ; store character and text characteristics in VGA

    add ebx, 1 ; next character in string
    add edx, 2 ; next 2 bytes in VGA

    jmp print_string_pm_loop

print_string_pm_end:
    popa
    ret
