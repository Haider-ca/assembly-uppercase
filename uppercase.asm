section .bss
	name resb 100

section .data
	prompt db "Enter Your Name: ", 0
	prompt_len equ $ - prompt

	newline db 0xA
	newline_len equ $ - newline

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, prompt_len
	int 0x80

	mov eax, 3
	mov ebx, 0
	mov ecx, name
	mov edx, 100
	int 0x80
	mov esi, eax

	mov ecx, 0

convert_loop:
	cmp ecx, esi
	jge done_convert

	mov al, [name + ecx]
	cmp al, 'a'
	jl skip
	cmp al, 'z'
	jg skip
	sub al, 32
	mov [name + ecx], al

skip:
	inc ecx
	jmp convert_loop

done_convert:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, newline_len
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, esi
	int 0x80

	mov eax, 1
	xor ebx, ebx
	int 0x80

