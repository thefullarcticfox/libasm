			global		ft_strlen

			section		.text
ft_strlen:
			mov			rax, 0				; i = 0

while:
			cmp			byte[rdi + rax], 0	; *(str + i) == 0 ?
			jz			return
			inc			rax					; i++
			jmp			while

return:
			ret
