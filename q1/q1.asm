org 0x7c00
jmp 0x0000:start

a db 0
b db 0
c db 0
e db 0

r1 db 0
r2 db 0
r3 db 0

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
	mov ah, 0x0e
	int 10h
	ret

endl:
	mov al, 10
	call putchar
	mov al, 13
	call putchar
	jmp load

saveA:
	sub al, 48
	mov [a], al
	inc ch
	jmp load

saveB:
	sub al, 48
	mov [b], al
	inc ch
	jmp load

saveC:
	sub al, 48
	mov [c], al
	inc ch
	jmp load

saveE:
	sub al, 48
	mov [e], al
	inc ch
	jmp calc

load:
	loop1:
		lodsb
		cmp ch, 0
		je saveA
		cmp ch, 2
		je saveB
		cmp ch, 4
		je saveC
		cmp ch, 6
		je saveE
		inc ch
		jmp load

sout:
	mov ah, 0
	;call putchar
	mov bp, ax
	mov ax, bp
	mov bl, 10
	div bl
	add al, 48
	mov bl, ah
	call putchar
	mov al, bl
	add al, 48
	call putchar
	jmp bac

sout2:
	mov ah, 0
	;call putchar
	mov bp, ax
	mov ax, bp
	mov bl, 10
	div bl
	add al, 48
	mov bl, ah
	call putchar
	mov al, bl
	add al, 48
	call putchar
	jmp end

calc:
	mov ax, [a]
	mov cx, [e]
	mul cx
	mov bx, ax
	mov ax, [c]
	mov cx, [b]
	mul cx
	add ax, bx
	cmp al, 10
	jge sout
	add ax, 48
	call putchar
	bac:
	mov al, 47
	call putchar
	mov ax, [b]
	mov cx, [e]
	mul cx
	cmp al, 10
	jge sout2
	add ax, 48
	call putchar
	jmp end

;prints:
;	loop1:
;		lodsb
;		inc ch
;		cmp ch, cl
;		je end
;		cmp al, 0
;		je end
;		call putchar
;		jmp loop1

end:
times 510 - ($ - $$) db 0
dw 0xaa55
