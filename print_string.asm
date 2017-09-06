; prints characters from address in bx until there's a 0

print_string:
    ; pushes all register values onto stack
    pusha
    ; sets to tty mode, which is necessary to write to screen
    mov ah, 0x0e

loop:
    mov al, [bx]
    ; compares al to 0
    ; comparison results are saved and used for conditions
    cmp al, 0
    ; jump to end if equal to 0
    je end

    ; otherwise, print the character
    int 0x10

    ; increment to next character-byte
    add bx, 1
    ; reiterate
    jmp loop

end:
    ; pops register values back into registers
    popa
    ; jumps to the address following the caller of the function
    ret
