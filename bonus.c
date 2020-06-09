#include "includes/libasm.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <strings.h>

int main()
{
	t_list		*head;
	head = 0;
	ft_list_push_front(&head, "1");
	ft_list_push_front(&head, "2");
	ft_list_push_front(&head, "3");
	ft_list_push_front(&head, "4");
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
