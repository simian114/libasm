; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_strlen.s                                        :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2020/06/04 11:18:50 by sanam             #+#    #+#              #
;    Updated: 2020/06/04 11:59:52 by sanam            ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

;size_t		ft_strlen(char *s)
;{
;	size_t	i;
;
;	i = 0;
;	while (s[i])
;		i++;
;	return (i);
;}

section .text
	global _ft_strlen

_ft_strlen:
	xor rax, rax

strlen_loop:
	cmp byte [rdi + rax], 0x0
	je strlen_end
	inc rax
	jmp strlen_loop

strlen_end:
	ret
