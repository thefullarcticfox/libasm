			global		ft_strcmp

			section		.text
ft_strcmp:
			mov			rax, 0					; diff = 0
			mov			rcx, 0					; i = 0

while:
			cmp			byte[rdi + rcx], 0		; *(s1 + i) == 0 ?
			jz			return
			cmp			byte[rsi + rcx], 0		; *(s2 + i) == 0 ?
			jz			return
			mov			al, byte[rdi + rcx]
			cmp			al, byte[rsi + rcx]
			jnz			return					; diff != 0
			inc			rcx						; i++
			jmp			while

return:
			mov			rdx, 0
			mov			al, byte[rdi + rcx]
			mov			dl, byte[rsi + rcx]
			sub			rax, rdx
			ret
