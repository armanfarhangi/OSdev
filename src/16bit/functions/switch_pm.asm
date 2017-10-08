; all actions necessary before switching to protected mode

[bits 16]
switch_pm:
    ; disable interrupts; the BIOS interrupt vector table is only good for 16bit mode
    cli

    ; give CPU info about GDT
    lgdt[gdt_descriptor]

    ; set last bit of cr0 register to 1
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    ; we need to flush the pipeline before switching modes
    ; this can be done by a far jump, i.e. a jump to another segment
    ; syntax is very similar to manual 16bit segment register overlap, e.g. es:address...
    ; ...however, in 32bit mode, the segment is referenced by its index in the GDT
    ; this instruction sets cs register to CODE_SEG automatically
    jmp CODE_SEG:init_pm
