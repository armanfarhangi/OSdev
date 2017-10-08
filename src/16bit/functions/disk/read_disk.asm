; loads amount of sectors (dh) into address es:bx

read_disk:
    pusha

    ; need to overwrite dh for disk read interrupt...
    ; ... so push to stack to use later for error checking
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

    ; if there's a carry bit, there's an error
    jc disk_error

    ; get number of sectors back from stack
    ; compare to actual amount read
    pop dx
    cmp al, dh
    jne sector_error

    popa
    ret

disk_error:
    mov bx, DISK_ERROR_MESSAGE
    call print_string
    call print_nl
    jmp $

sector_error:
    mov bx, SECTOR_ERROR_MESSAGE
    call print_string
    call print_nl
    jmp $

DISK_ERROR_MESSAGE:
    db 'Error reading disk', 0

SECTOR_ERROR_MESSAGE:
    db 'Incorrect number of sectors read', 0
