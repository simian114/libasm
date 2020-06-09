;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*))
;{
;	t_list	*prev;
;	t_list	*curr;
;
;	while (*begin_list)
;	{
;		if (cmp(*temp->content, data->ref) == 0)
;		{
;			t_list *temp;
;			temp = *begin_list;
;			*begin_list = *begin_list->next;
;			free_fct(temp->content);
;			free(temp);
;		}
;		else
;			break ;
;	}
;	prev = *begin_list;
;	while (prev)
;	{
;		curr = prev->next;
;		if (curr== 0)
;			return ;
;		else if (cmp(curr->content, data_ref) == 0)
;		{
;			prev->next = curr->next;
;			free_fct(curr->content);
;			free(curr);
;		}
;		else
;			prev = curr;
;	}
;}

section .text
extern free
	global ft_list_remove_if

ft_list_remove_if:
	check_param:
;		cmp rdi, 0	; rdi = **begin_list
;		je fin 
;		cmp rsi, 0	; rsi = data_ref
;		je fin
;		cmp rdx, 0	; rdx = cmp
;		je fin
;		cmp rcx, 0	; r10 = free_fct 왜 r10이 아니라 rcx?
;		je fin
	mov r11, rdi	; r11 = **begin_list
	mov r12, rsi	; r12 = *data_ref
	mov r13, rdx	; r13 = cmp()
	mov r14, rcx	; r14 = free_fct
	mov r15, [r11]	; r15 = *begin_list
	check_first:
		cmp r15, 0
		je fin;
		mov rdi, r15	; rdi = *begin
		mov rdi, [rdi]	; rdi = *begin->content
		mov rsi, r12
		call r13		; ft_strcmp(s1, s2); return rax;
		cmp rax, 0		; if rax == 0, remove
		jne remove_loop_1; if not equal, jump remove_loop
		mov r8, r15	; r8 = *begin
		mov r9, r8		; r9 = *begin
		mov r8, [r8 + 8]; r8 = *begin->next
		mov r15, r8	;*begin = *begin->next
		mov rdi, [r9]; rdi = *begin->content
		push r11
		call r14
		pop r11
		mov rdi, r9
		call free
		jmp check_first

	remove_loop_1:
		mov [r11], r15

	remove_loop:
		cmp r15, 0
		je fin
		mov r8, r15	; r8 = *prev
		mov r9, [r15 + 8]; r9 = *curr
		cmp r9, 0	; if (curr == 0)
		je fin
		mov rdi, [r9]
		mov rsi, r12
		call r13 ; cmp
		cmp rax, 0
		jne loop_else ; 
						; else if (cmp == 0)
		;r9 = curr
		;r8 = prev
	;mov rdi, [r9]
		mov rcx, [r9 + 8]
		mov [r15 + 8], rcx; prev->next = curr
		mov rdi, [r9]	; rdi = curr->content
		push r11
		call r14		;free(curr->content)
		pop r11
		mov rdi, r9
		call free
		jmp remove_loop

	loop_else:; cmp != 0
		mov r15, [r15 + 8]
		jmp remove_loop
;
;	while (prev)
;	{
;		curr = prev->next;
;		if (curr== 0)
;			return ;
;		else if (cmp(curr->content, data_ref) == 0)
;		{
;			prev->next = curr->next;
;			free_fct(curr->content);
;			free(curr);
;		}
;		else
;			prev = curr;
;	}
fin:
	ret
