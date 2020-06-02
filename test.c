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
	ft_read(0, test, 10);
	printf("=========== ft_write ================\n");
	int ret = ft_write(1, test, ft_strlen(test));
	printf("=========== ft_strlen ================\n");
	printf("\nft_strlen : %ld\n", ft_strlen(test));
	printf("=========== ft_strcmp ================\n");
	char *a = "abcd";
	char *b = "abc1";
	int z = ft_strcmp(a, b);
	printf("cmp : %d\n",z);
}
