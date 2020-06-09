# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sanam <marvin@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/06/02 00:52:00 by sanam             #+#    #+#              #
#    Updated: 2020/06/09 16:30:50 by sanam            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC		=	gcc
NAME	=	libasm.a
NASM	=	nasm
FLAGS	=	-f macho64
INC		=	includes/libasm.h
SRC		=	srcs/ft_write.s \
			srcs/ft_strlen.s	\
			srcs/ft_read.s		\
			srcs/ft_strcmp.s	\
			srcs/ft_strcpy.s	\
			srcs/ft_strdup.s
BONUS	=	srcs/ft_list_push_front.s	\
			srcs/ft_list_size.s
OBJ		=	$(SRC:.s=.o)
OBJ_BONUS	=	$(BONUS:.s=.o)

all		:	$(NAME)

$(NAME)	:	$(OBJ)
			ar rc $(NAME) $(OBJ)
			ranlib $(NAME)

bonus	:	$(NAME) $(OBJ_BONUS)
			ar -rcs $(NAME) $^
			ranlib $(NAME)

%.o		:	%.s
			$(NASM) -I$(INC) $(FLAGS) $< -o $@

clean	:
			rm -rf $(OBJ) $(OBJ_BONUS)

fclean	:	clean
			rm -rf $(NAME)

re		:	fclean all

test	:	re
			$(CC) -o test tester.c -L. -lasm
			./test

bt		:	bonus
			$(CC) -o bonus bonus.c -L. -lasm
			./bonus

.PHONY: all, clean, fclean, re, bonus
