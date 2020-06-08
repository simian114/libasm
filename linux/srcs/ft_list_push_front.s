;* ************************************************************************** */
;*                                                                            */
;*                                                        :::      ::::::::   */
;*   ft_list_push_front.c                               :+:      :+:    :+:   */
;*                                                    +:+ +:+         +:+     */
;*   By: sanam <marvin@42.fr>                       +#+  +:+       +#+        */
;*                                                +#+#+#+#+#+   +#+           */
;*   Created: 2020/06/08 09:42:32 by sanam             #+#    #+#             */
;*   Updated: 2020/06/08 09:42:57 by sanam            ###   ########.fr       */
;*                                                                            */
;* ************************************************************************** */

;void	ft_list_push_front(t_list **list, void *data)
;{
;	t_list *new;
;
;	new= malloc(16);
;	if (new == 0)
;		return ;
;	new->content = data;
;	new->next = *list;
;	*list = node;
;}
section .text
extern malloc
global ft_list_push_front
ft_list_push_front:
		push rdi
		push rsi
		mov rdi, 16
		call malloc
		cmp rax, 0
		je error ; malloc fail
		pop rsi
		pop rdi
		mov [rax], rsi
		mov rcx, [rdi]
		mov [rax + 8], rcx
		mov [rdi], rax

error:
		ret
