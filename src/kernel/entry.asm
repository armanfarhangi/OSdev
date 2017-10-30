[bits 32]

; includes an unresolved reference to a label called "main", which is the core kernel function
[extern main]

call main

; once main function of kernel returns, then there will be an infinite loop
jmp $
