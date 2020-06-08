#include "includes/libasm.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <strings.h>

int main()
{
//	char *z;
//	char test[100];
//	memset(test, 0, 100);
//	printf("=========== ft_read ================\n");
//	int a = ft_read(0, z, 100);
//	printf("a : %d\n", a);
//	//printf("[%s]\n", strerror(errno));
//	printf("[%s]\n", strerror(errno));
//	printf("=========== ft_write ================\n");
//	int ret = ft_write(1, test, ft_strlen(test));
//	printf("=========== ft_strlen ================\n");
//	printf("ft_strlen : %ld\n", ft_strlen(test));
//	printf("=========== ft_strcmp ================\n");
//	char *a = "abcd";
//	char *b = "abcd";
//	int z = ft_strcmp(a, b);
//	printf("cmp : %d\n",z);
//	printf("=========== ft_strcpy ================\n");
//	char *s = "1234";
//	char dest[100];
//	ft_strcpy(dest, s);
//	printf("dest : %s\n", dest);
//	printf("=========== ft_strdup ================\n");
//	char *dup = ft_strdup("1234");
//	printf("dup : %s\n", dup);
	t_list		*head;
	head = 0;
	ft_list_push_front(&head, "1");
	ft_list_push_front(&head, "2");
	ft_list_push_front(&head, "3");
	ft_list_push_front(&head, "4");
//	t_list *temp = head;
//	while (temp)
//	{
//		printf("[%s]\n", (char *)temp->content);
//		temp = temp->next;
//	}
	printf("size : [%d]\n", ft_list_size(head));
}
