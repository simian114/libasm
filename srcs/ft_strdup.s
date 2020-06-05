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
extern _malloc
extern _ft_strlen
extern _ft_strcpy
	global _ft_strdup

_ft_strdup:
	call _ft_strlen
	inc rax
	push rdi
	mov rdi, rax
	call _malloc
	cmp rax, 0
	je failed
	pop rsi
	mov rdi, rax
	call _ft_strcpy
	ret

failed:
	ret
