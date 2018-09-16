org 0x7c00
jmp 0x0000:start

dia db 0 
mes db 0
ano db 0
c db 0

start:
	xor ax, ax
	xor bx, bx
	mov ds, ax
	mov es, ax
	jmp gets		


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

count:
	inc ch
	inc bl
	jmp loop1

incDia:
	sub al, 48
	add [dia], al
	jmp bac1

incMes:
	sub al, 48
	add [mes], al
	jmp bac2

incAno:
	sub al, 48
	add [ano], al
	mov al, [ano]
	jmp bac3

load:
	sub cl, 1
	loop1:
		lodsb
		cmp al, 45
		je count		
		cmp bl, 0
		je incDia
		bac1:
		cmp bl, 1
		je incMes		
		bac2:
		cmp bl, 2
		je incAno
		bac3:
		inc ch
		cmp ch, cl
		je soma
		jmp loop1

soma:
	xor bl, bl
	mov al, [dia]
	cmp al, 10
	jge ident1
	bac4:
	mov al, [ano]
	;call putchar
	cmp al, 10
	jge ident2
	bac5:
	xor bl, bl
	add bl, [dia]
	add bl, [mes]
	add bl, [ano]
	mov al, bl
	cmp al, 10
	jge ident3
	add al, 48
	call putchar
	jmp end


ident1:
	mov ah, 0
	mov [dia], ah
	mov bl, 10
	div bl
	add [dia], al
	add [dia], ah
	mov al, [dia]
	;add al, 48
	;call putchar
	jmp bac4

ident2:
	mov ah, 0
	mov [ano], ah
	mov bl, 10
	div bl
	add [ano], al
	add [ano], ah
	mov al, [ano]
	jmp bac5

ident3:
	mov ah, 0
	mov bl, 10
	div bl
	add al, ah
	add al, 48
	call putchar

end:
times 510 - ($ - $$) db 0
dw 0xaa55
