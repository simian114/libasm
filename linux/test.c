#include "includes/libasm.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <strings.h>

void	free_z(void *data)
{
	free((char *)data);
}

int main()
{
	t_list		*head;
	head = 0;
	//ft_list_push_front(&head, ft_strdup("1"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("2"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("2"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("2"));
	ft_list_push_front(&head, ft_strdup("2"));
	ft_list_remove_if(&head, "3", ft_strcmp, free_z);
	t_list *temp = head;
	while (temp)
	{
		printf("[%s]", (char *)temp->content);
		if (temp->next)
			printf(" --> ");
		temp = temp->next;
	}
	printf("\nsize : [%d]\n", ft_list_size(head));
}
