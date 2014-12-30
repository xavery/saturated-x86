INT_MIN equ 0x80000000
INT_MAX equ 0x7fffffff
CF_BIT  equ 0
SF_BIT  equ 7
OF_BIT  equ 11

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
    mov eax, INT_MIN
    ret

.max:
    mov eax, INT_MAX
    ret

global sadd_pushf_cmov
sadd_pushf_cmov:
    mov ecx, INT_MIN
    mov edx, INT_MAX
    
    add esi, edi
    
    pushf
    pop rax
    not rax
    
    test ax, ((1 << OF_BIT) | (1 << CF_BIT))
    cmovz esi, ecx
    
    test ax, ((1 << OF_BIT) | (1 << SF_BIT))
    cmovz esi, edx

    mov eax, esi
    ret

global sadd_setcc_cmov
sadd_setcc_cmov:
    mov r15d, INT_MIN
    mov r14d, INT_MAX
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
