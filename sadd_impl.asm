bits 32
global sadd
sadd:
    add esi, edi
    jo .over

.ok:
    mov eax, esi
    ret
    
.over:
    js .max
    
.min:
    mov eax, 0x80000000
    ret

.max:
    mov eax, 0x7fffffff
    ret
