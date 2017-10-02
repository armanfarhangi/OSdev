; prints a new line and return carriage

print_nl:
    pusha
    mov ah, 0x0e

    ; newline character
    mov al, 0x0a
    int 0x10

    ; carriage return (sets cursor at beginning of new line)
    mov al, 0x0d
    int 0x10

    popa
    ret
