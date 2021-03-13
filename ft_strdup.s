			global		ft_strdup
			extern		malloc
			extern		ft_strlen
			extern		ft_strcpy

			section		.text
ft_strdup:
			call		ft_strlen
			inc			rax					; strlen + 1 for nullterm
			push		rdi					; save rdi
			mov			rdi, rax			; strlen return to 1st arg
			call		malloc WRT ..plt	; bit directive WRT and special keyword ..plt
			pop			rdi					; restore rdi
			cmp			rax, 0				; did malloc return NULL ?
			jz			error				; jump to error if it did
			mov			rsi, rdi			; move rdi to 2nd arg
			mov			rdi, rax			; move rax to 1st arg
			call		ft_strcpy
			ret

error:										; errno set by malloc
			ret								; rax already zero after malloc
