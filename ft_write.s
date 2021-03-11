			global		_ft_write
			extern 		___error

			section		.text
_ft_write:								; args: rdi, rsi, rdx, rcx, r8, r9
			push		rbx				; align callstack (must do on mac)
			mov			rax, 0x02000004	; mac syscall write
			syscall
			jc			error			; jump if carry error
			pop			rbx				; restore rbx
			ret

error:
			mov			rdx, rax		; move returned errno from syscall
			call		___error		; call error address
			mov			[rax], rdx		; set errno to error address
			mov			rax, -1			; return -1
			pop			rbx				; restore rbx
			ret
