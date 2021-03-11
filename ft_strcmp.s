			global		_ft_strcmp

			section		.text
_ft_strcmp:
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
			mov			al, byte[rdi + rcx]
			cmp			al, byte[rsi + rcx]
			ja			returng					; diff > 0
			jb			returnl					; diff < 0
			ret									; else return 0

returng:
			mov			al, byte[rdi + rcx]
			sub			al, byte[rsi + rcx]
			ret

returnl:
			mov			al, byte[rdi + rcx]
			sub			al, byte[rsi + rcx]
			sub			rax, 256
			ret
