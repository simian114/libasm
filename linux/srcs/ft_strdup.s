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

; 왜 push, pop을 이용해서 string을 저장했나?
; 처음에는 mov를 이용해서 rdi에 있는 포인터를 rsi로
; 이동시켰는데 이상하게 오류가 계속 난다.
; gdb를 이용해서 디버거 해본 결과 malloc함수를 사용하면
; 범용계열 레지스터들이 다른 값으로 바뀐다.
; 그래서 스택을 이용
ft_strdup:
	call ft_strlen
	inc rax		; rax + 1 because of NULL
	push rdi	; backup string pointer
	mov rdi, rax
	call malloc ; malloc(ft_strlen(string));
	cmp rax, 0	; if malloc failed, rax = 0(NULL)
	je failed	; jump error
	pop rsi		; rsi = string pointer
	mov rdi, rax
	call ft_strcpy
	ret

failed:
	ret
