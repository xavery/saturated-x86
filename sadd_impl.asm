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

global sadd_setcc_cmov
sadd_setcc_cmov:
    mov r15d, 0x80000000
    mov r14d, 0x7fffffff
    mov eax, esi
    xor esi, esi
    xor ecx, ecx
    xor edx, edx
    
    add eax, edi
    seto dl
    setc cl
    sets sil
    
    test dl, cl
    cmovnz eax, r15d
    
    test dl, sil
    cmovnz eax, r14d
    
    ret
