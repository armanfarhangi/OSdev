; loads amount of sectors (dh) into address es:bx

read_disk:
    pusha

    ; need to overwrite dh for disk read interrupt
    ; push to stack to use later for error checking
    push dx

    ; disk read operation value
    mov ah, 0x02

    ; number of sectors
    mov al, dh

    ; number of sector to begin at (sectors are not 0-based)
    mov cl, 0x02

    ; track/cylinder number
    mov ch, 0x00

    ; head number
    mov dh, 0x00

    ; interrupt for reading disk
    int 0x13

    popa
    ret
