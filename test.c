#include "includes/libasm.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <strings.h>

int main()
{
	char test[100];
	memset(test, 0, 100);
	printf("=========== ft_read ================\n");
	ft_read(3, test, 100);
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
//	char *dup = ft_strdup("asdfasdfasfsadfsdaf");
//	printf("dup : %s\n", dup);
}
