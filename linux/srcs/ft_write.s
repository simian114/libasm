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
global ft_write

ft_write:
	mov rax, 1
	syscall
	ret
