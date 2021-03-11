NAME = libasm.a
SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
OBJ = $(SRC:.s=.o)

NA = nasm
NAFLAGS = -f macho64 -Werror
CC = gcc
CFLAGS = -Wall -Wextra -Werror -I./
LIBFLAGS = -L./ -lasm
EXECFLAGS = $(CFLAGS) $(LIBFLAGS)
TESTSRC = main.c
TESTEXE = runtest

.PHONY: all bonus clean fclean re

all: $(NAME)

$(NAME): $(OBJ)
	ar rcs $(NAME) $?

%.o: %.s
	$(NA) $(NAFLAGS) $< -o $@

$(TESTEXE): $(TESTSRC) $(NAME)
	$(CC) -o $@ $< $(EXECFLAGS)
	./$(TESTEXE)

clean:
	@/bin/rm -f $(OBJ) $(BONUSOBJ)

fclean: clean
	@/bin/rm -f $(NAME)
	@/bin/rm -f $(TESTEXE)

re: fclean all
