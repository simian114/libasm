; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_strcpy.s                                        :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2020/06/04 13:03:05 by sanam             #+#    #+#              #
;    Updated: 2020/06/04 13:03:05 by sanam            ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

;char	*ft_strcpy(char *dest, char *src)
;{
;	int		i;
;
;	i = 0;
;	while (src[i])
;		dest[i] = src[i];
;	dest[i] = 0;
;	return (dest);
;}

section .text
global ft_strcpy

ft_strcpy:
	xor rcx, rcx
	xor rdx, rdx

strcpy_loop:
	mov dl, byte [rsi + rcx]; 여기서 cl을 사용하면 안된다. 
	cmp dl, 0				; 왜냐면 c 레지스터는 이미 인덱스로 사용하고 있기 때문
	je strcpy_end
	mov byte [rdi + rcx], dl; rdi가 가르키는 녀석은 char *s 이므로
	inc rcx					; 인덱스 당 하나의 char, 즉 1바이트가 들어가야한다.
	jmp strcpy_loop

strcpy_end:
	mov byte [rdi + rcx], 0 ; strcpy는 src의 null까지 dest에 넣어준다
	mov rax, rdi			; return은 무조건 rax 레지스터
	ret
