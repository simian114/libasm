; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_strcmp.s                                        :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2020/06/04 13:02:54 by sanam             #+#    #+#              #
;    Updated: 2020/06/04 13:02:54 by sanam            ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

;int		ft_strcmp(char *s1, char *s2)
;{
;	int i;
;
;	i = 0;
;	while (s1[i] && s1[i] == s2[i])
;		i++;
;	return (s1[i] - s2[i]);
;}

section .text
	global _ft_strcmp

_ft_strcmp:
	mov rcx, 0

strcmp_loop:
	mov byte dl, [rdi + rcx]; [rdi + 0] == s1[0] => char => 1byte
	mov byte dh, [rsi+ rcx]	; rdx ==64, edx == 32, dx == 16, dh == dl == 8 == 1byte
	inc rcx ; idx++
	cmp dl, 0 ; if dest[idx] == 0, end
	je strcmp_end_0
	cmp dl, dh
	je strcmp_loop ; if dest[idx] == src[idx], loop again
	jl strcmp_end_1
	jg strcmp_end_2

strcmp_end_0:
	cmp dh, 0
	jne strcmp_end_1
	xor rax, rax
	ret

strcmp_end_1:
	mov rax, -1
	ret

strcmp_end_2:
	mov rax, 1
	ret
