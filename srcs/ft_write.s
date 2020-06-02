section .text
global ft_write

ft_write:
	mov rax, 1
	syscall
	ret
