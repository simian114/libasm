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
extern __errno_location
;extern ___error
global ft_read

ft_read:
	xor rax, rax
	syscall
	cmp rax, 0
	jl err
	ret

err:
	; 음수인 rax를 뒤집은 값이 errno
	neg rax ;2의 보수를 취하기 전에는 rax : -9 취하면 9
	;왜 push하고 pop 하는지 알아내자..
	push rax
	call __errno_location ; 이 함수를 호출하면 rax에는 errno를 가리키는 포인터가 된다.
	pop qword [rax] ; 아까 푸쉬해놓은 정수를 rax가 가리키는 곳에 넣는다.
					; rax는 현재 포인터이므로 [  ]를 사용했고 qword를 사용하는 이유는
					; rax는 64비트이기 때문에 8바이트 == 64 비트 형식으로 값을 넣는것임.
	mov rax, -1 ; 이 연산을 해주면 rax 레지스터는 주소 포인터가 아니라 그냥 -1 가 된다.
	ret
