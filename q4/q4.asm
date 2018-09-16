org 0x7c00
jmp 0x0000:start

start: ;comeco
	xor ax, ax ;zera registradores
	mov ds, ax
	mov es, ax
	jmp gets ;pega a string

gets: ;pega a string
	xor cx, cx
	loop:
		call getchar ;pega um caracter
		inc cl
		stosb ;salva o caracter
		cmp al, 13
		je endl ;senao, finaliza o programa
		call putchar ;mostra na tela o caracter
		jmp loop

getchar:
	mov ah, 0h
	int 16h
	ret

putchar:
	cmp ax, 13
	je end
	mov ah, 0x0e
	int 10h
	ret

endl:
	mov al, 10
	call putchar
	stosb
	mov al, 13
	call putchar
	jmp inv

inv:
	mov di, si
	xor bx, bx
	loop1:
		lodsb
		inc ch
		cmp ch, cl
		je loop2
		inc bl
		push ax
		jmp loop1
	loop2:
		cmp bl, 0
		je end
		dec bl
		pop ax
		stosb
		call putchar
		jmp loop2
end:
times 510 - ($ - $$) db 0
dw 0xaa55
