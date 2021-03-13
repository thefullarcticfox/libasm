			global		ft_read
			extern 		__errno_location

			section		.text
ft_read:											; args: rdi, rsi, rdx, rcx, r8, r9
			mov			rax, 0						; linux syscall read
			syscall
			cmp			rax, 0
			jl			error						; jump if less than 0 to error
			ret

error:
			mov			rdx, rax					; move returned errno from syscall
			call		__errno_location WRT ..plt	; call errno address
			neg			rdx							; change sign
			mov			[rax], rdx					; set errno to error address
			mov			rax, -1						; return -1
			ret
