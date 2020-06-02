# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/06/02 00:52:00 by sanam             #+#    #+#              #
#    Updated: 2020/06/02 17:27:23 by sanam            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME	=	libasm.a
NASM	=	nasm
FLAGS	=	-f elf64
INC		=	includes/libasm.h
SRC		=	srcs/ft_write.s \
			srcs/ft_strlen.s	\
			srcs/ft_read.s		\
			srcs/ft_strcmp.s
OBJ		=	$(SRC:.s=.o)

all		:	$(NAME)

$(NAME)	:	$(OBJ)
			ar rc $(NAME) $(OBJ)
			ranlib $(NAME)

%.o		:	%.s
			$(NASM) -I$(INC) $(FLAGS) $< -o $@

clean	:
			rm -rf $(OBJ) $(OBJ_b)

fclean	:	clean
			rm -rf $(NAME)

re		:	fclean all

.PHONY: all, clean, fclean, re, bonus
