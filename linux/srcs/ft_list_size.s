
;int ft_list_size(t_list *begin_list)
;{
;	int		ret;
;
;	ret = 0;
;	while (begin_list)
;	{
;		ret++;
;		begin_list = begin_list->next;
;	}
;	return (ret);
;}

section .text
	global ft_list_size

ft_list_size:
		xor rax, rax
		mov rsi, rdi
size_loop:
		cmp rsi, 0
		je size_end
		inc rax
		mov rsi, [rsi + 8]
		jmp size_loop
size_end:
		ret
