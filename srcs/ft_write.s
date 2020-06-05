; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_write.s                                         :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2020/06/04 13:03:35 by sanam             #+#    #+#              #
;    Updated: 2020/06/04 13:03:35 by sanam            ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

section .text
extern ___error
	global _ft_write

_ft_write:
	mov rax, 0x2000004
	syscall
	ret

err:
	push rax
	call ___error
	pop qword [rax]
	mov rax, -1
	ret
