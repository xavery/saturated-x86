bits 64
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

global sadd_pushf_cmov
sadd_pushf_cmov:
    mov ecx, 0x80000000
    mov edx, 0x7fffffff
    
    add esi, edi
    
    pushf
    pop rax
    not rax
    
    test ax, 0x0801
    cmovz esi, ecx
    
    test ax, 0x0880
    cmovz esi, edx

    mov eax, esi
    ret
