org 0x7c00
jmp 0x0000:start

s db 0
r db 0
m db 0

start: ;comeco
	xor ax, ax ;zera registradores
	mov ds, ax
	mov es, ax
	jmp gets ;pega a string

gets: ;pega a string
	xor cx, cx
	loop:
		call getchar ;pega um caracter
		stosb ;salva o caracter
		cmp al, 13
		je endl ;senao, finaliza o programa
		inc cl
		call putchar ;mostra na tela o caracter
		jmp loop

getchar:
	mov ah, 0h
	int 16h
	ret

putchar:
	mov ah, 0x0e
	int 10h
	ret

endl:
	mov al, 10
	call putchar
	mov al, 13
	call putchar
	jmp getc

getc:
	mov ah, 0h
	int 16h
	call putchar
	mov [s], al
	loop2:
		mov ah, 0h
		int 16h
		cmp al, 8
		je backspace
		cmp al, 13
		mov al, 10
		call putchar
		mov al, 13
		call putchar
	jmp search

backspace:
	mov al, 8
	call putchar
	mov al, ''
	call putchar
	mov al, 8
	call putchar
	jmp getc

search:
	loop1:
		lodsb
		inc ch
		cmp ch, cl
		je result
		cmp al, [s]
		je verif
		jmp resto
		verif:
			inc bh
		resto:
			jmp loop1

correct:
	mov bx, 10
	mov ax, cx
	div bx
	call putchar
	;mov [r], al
	;mov [m], ah
	;xor ax, ax
	;mov al, [r]
	;call putchar
	;mov al, [m]
	;call putchar
	ret

ident:
	mov ah, 0
	mov bl, 10
	mov al, cl
	div bl
	add al, 48
	mov bh, ah 
	call putchar
	mov al, bh
	add al, 48
	call putchar
	jmp end

ident2:
	mov ah, 0
	mov bl, 10
	mov al, cl
	div bl
	add al, 48
	mov bh, ah 
	call putchar
	mov al, bh
	add al, 48
	call putchar
	jmp bac

result:
	mov al, bh
	xor bh, bh
	xor ch, ch
	cmp al, 9
	jg ident2
	add al, 48
	call putchar
	bac:
	mov al, 47
	call putchar
	cmp cl, 9
	jg ident
	add cl, 48
	mov al, cl
	call putchar
	jmp end

end:
times 510 - ($ - $$) db 0
dw 0xaa55