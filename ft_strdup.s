			global		_ft_strdup
			extern		_malloc
			extern		_ft_strlen
			extern		_ft_strcpy

			section		.text
_ft_strdup:
			call		_ft_strlen
			inc			rax				; strlen + 1 for nullterm
			push		rdi				; save rdi + align callstack
			mov			rdi, rax		; strlen return to 1st arg
			call		_malloc			; callstack already aligned
			pop			rdi				; restore rdi
			cmp			rax, 0			; did malloc return NULL ?
			jz			error			; jump to error if it did
			mov			rsi, rdi		; move rdi to 2nd arg
			mov			rdi, rax		; move rax to 1st arg
			call		_ft_strcpy
			ret

error:									; errno set by malloc
			ret							; rax already zero after malloc
