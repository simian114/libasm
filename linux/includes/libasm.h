#ifndef LIBASM_H
# define LIBASM_H

# include <stdlib.h>
# include <unistd.h>
# include <error.h>
# include <errno.h>

typedef struct		s_list
{
	void			*content;
	void			*next;
}					t_list;

void		ft_list_push_front(t_list **list, void *data);
int			ft_list_size(t_list *begint_list);
void		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
void		free_fct(void *data);

extern int errno;

ssize_t		ft_write(int fd, const void *buf, size_t nbyte);
size_t		ft_strlen(const char *s);
size_t		ft_read(int fd, void *buf, size_t count);
int			ft_strcmp(const char *s1, const char *s2);
char		*ft_strcpy(char *dest, const char *src);
char		*ft_strdup(const char *s);

#endif
