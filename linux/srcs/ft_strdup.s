; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_strdup.s                                        :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2020/06/04 13:01:40 by sanam             #+#    #+#              #
;    Updated: 2020/06/04 13:01:40 by sanam            ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

;char	*ft_strdup(char *s)
;{
;	int		len;
;	char	*ret;
;
;	len = (int)ft_strlen(s);
;	ret = malloc(sizeof(char) * (len + 1));
;	if (ret == 0)
;		return (0);
;	ft_strlcpy(ret, s, len + 1);
;	return (ret);
;}

section .text
extern malloc
extern ft_strlen
extern ft_strcpy
global ft_strdup

ft_strdup:
	call ft_strlen
	inc rax
	push rdi
	mov rdi, rax
	call malloc
	cmp rax, 0
	je failed
	pop rsi
	mov rdi, rax
	call ft_strcpy
	mov rax, rdi
	ret

failed:
	ret
