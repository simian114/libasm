; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_read.s                                          :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2020/06/04 13:02:42 by sanam             #+#    #+#              #
;    Updated: 2020/06/04 13:02:42 by sanam            ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

section .text
extern ___error
	global _ft_read

_ft_read:
	mov rax, 0x2000003
	syscall
	jc err
	ret

err:
	push rax
	call ___error
	pop qword [rax]
	mov rax, -1
	ret
