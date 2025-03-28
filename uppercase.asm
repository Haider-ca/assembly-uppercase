section .data
    prompt db 'Enter your name: ', 0
    result db 'Result: ', 0
    buffer times 50 db 0

section .text
    global _start

_start:
    ; Print prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 16
    int 0x80

    ; Read input
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 50
    int 0x80

    ; Convert to uppercase
    mov esi, buffer
loop:
    mov al, [esi]
    cmp al, 0
    je done
    cmp al, 'a'
    jl skip
    cmp al, 'z'
    jg skip
    sub al, 32
    mov [esi], al
skip:
    inc esi
    jmp loop

done:
    ; Print result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 8
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    int 0x80

    ; Exit
    mov eax, 1
    int 0x80
