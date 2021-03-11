			global		_ft_strcpy

			section		.text
_ft_strcpy:
			mov			rcx, 0					; i = 0

while:
			mov			dl, byte[rsi + rcx]		; tmp = *(src + i)
			mov			byte[rdi + rcx], dl		; *(dst + i) = tmp
			cmp			dl, 0					; tmp == 0 ?
			jz			return
			inc			rcx						; i++
			jmp			while

return:
			mov			rax, rdi				; copy dst to return
			ret
