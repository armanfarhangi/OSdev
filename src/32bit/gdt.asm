; global descriptor table
; this data sets parameters for our new, protected 32bit mode segments
; in 32bit mode, segment registers aren't just values...
; ...but indexes to segment descriptors in GDT
; each descriptor is 8 bytes long; these bytes describe the segment

gdt_start:
    ; the first descriptor is simply null
    ; after switching to 32bit mode, if a segment register isn't updated...
    ; these null bytes will cause the CPU to raise an exception
    dd 0x0
    dd 0x0

; code segment
gdt_code:
    dw 0xffff    ; length: bits 0-15
    dw 0x0       ; base address: bits 0-15
    db 0x0       ; base address: bits 16-23
    db 10011010b ; present in memory 1; privilege level 00; code/data or trap 1; code or data 1; conforming 0; readable 1; accessed 0
    db 11001111b ; granularity 1; 32 or 16bit 1; 64bit 0; AVL 0; length: bits 16-19
    db 0x0       ; base address: bits 24-31

; data segment
; only a few differences between code segment (type and writable)
gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b ;
    db 11001111b
    db 0x0

gdt_end:

; GDT descriptor
; 6 bytes; necessary for CPU to utilize GDT
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; length
    dd gdt_start ; address

; index values for our segment registers after switching to 32bit mode
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
