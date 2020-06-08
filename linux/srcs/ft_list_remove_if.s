# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_remove_if.s                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/06/08 12:58:43 by sanam             #+#    #+#              #
#    Updated: 2020/06/08 14:40:56 by sanam            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*))
;{
;	t_list	*prev;
;	t_list	*curr;
;
;	prev = *begin_list;
;
;	while (prev)
;	{
;		if (cmp(prev->content, data->ref) == 0)
;		{
;			t_list *temp;
;			temp = prev->next;
;			free_fct(prev->content);
;			free(prev);
;			prev = temp;
;		}
;		else break ;
;	}
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

;section .text
;extern free
;	global ft_list_remove_if
;
;ft_list_remove_if:
;	check_param:
;		cmp rdi, 0	; rdi = **begin_list
;		je fin 
;		cmp rsi, 0	; rsi = data_ref
;		je fin
;		cmp rdx, 0	; rdx = cmp
;		je fin
;		cmp r10, 0	; r10 = free_fct
;		je fin
;	push rdi
;	push rsi
;	; r11 = prev
;	mov r11, [rdi]	; r11 = *begin_list
;	; looping
;	check_first:
;		cmp r11, 0
;		je fin;
;		mov rdi, [r11]
;		mov r12, [rsi]
;		call rdx
;		cmp rax, 0
;		mov rdi, [r11]
;	remove_loop:
;		cmp r11, 0
;		je fin
;		; r12 = curr
;		mov r12, [r11 + 8]	; r12 = prev->next = curr
;		cmp r12, 0	; if (curr == 0)
;		je fin
;		mov rdi, 
;
;fin:
;	ret
