#include "tester.h"

int     test_strlen(void)
{
    printf("\n");
    printf("------------------------------------------\n");
    printf("*               test_strlen              *\n");
    printf("------------------------------------------\n");
    char *a = "bonjour les petits enfants";
    char *b = "";
    char *d = "hey";

    // strlen (strlen segfaults with NULL pointer)
    printf("strlen:		%lu\nft_strlen:	%lu\n__\n",strlen(a), ft_strlen(a));
    printf("strlen:		%lu\nft_strlen:	%lu\n__\n",strlen(b), ft_strlen(b));
	printf("strlen:		%lu\nft_strlen:	%lu\n__\n",strlen(d), ft_strlen(d));

    return(0);
}

int     test_strcpy(void)
{

    printf("\n");
    printf("------------------------------------------\n");
    printf("*               test_strcpy              *\n");
    printf("------------------------------------------\n");
    char *a = "bonjour les petits enfants";
    char *b = "";
    char *d = "hey";
    char new_a[strlen(a) + 1];
	char ft_new_a[strlen(a) + 1];
	char new_b[strlen(b) + 1];
	char ft_new_b[strlen(b) + 1];
	char new_d[strlen(d) + 1];
	char ft_new_d[strlen(d) + 1];
    // char new_e[strlen(a) + 4];
	// char ft_new_e[strlen(a) + 4];
    // char new_f[strlen(a) - 8];
	// char ft_new_f[strlen(a) - 8];
	printf("strcpy:		%s\nft_strcpy:	%s\n__\n",strcpy(new_a, a), ft_strcpy(ft_new_a, a));
	printf("strcpy:		%s\nft_strcpy:	%s\n__\n",strcpy(new_b, b), ft_strcpy(ft_new_b, b));
	printf("strcpy:		%s\nft_strcpy:	%s\n__\n",strcpy(new_d, d), ft_strcpy(ft_new_d, d));
    //printf("strcpy:		%s\nft_strcpy:	%s\n__\n",strcpy(new_e, a), ft_strcpy(ft_new_e, a));
    //printf("strcpy:		%s\nft_strcpy:	%s\n__\n",strcpy(new_f, a), ft_strcpy(ft_new_f, a));
    //printf("strcpy:		%s\nft_strcpy:	%s\n__\n",strcpy(new_f, d), ft_strcpy(ft_new_f, d));
    return(0);
}


int     test_strcmp(void)
{
    printf("\n");
    printf("------------------------------------------\n");
    printf("*               test_strcmp              *\n");
    printf("------------------------------------------\n");
    printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("hey",""),ft_strcmp("hey",""));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("célestin  le peetit coquin","célestin  le petit coquin"),ft_strcmp("célestin  le peetit coquin","célestin  le petit coquin"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("célestin  le petit coquin","célestin  le petit coquin"),ft_strcmp("célestin  le petit coquin","célestin  le petit coquin"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("ho","ho"),ft_strcmp("ho","ho"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("",""),ft_strcmp("",""));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("hey","ho"),ft_strcmp("hey","ho"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("célestin  le ptit coquin","célestin  le petit coquin"),ft_strcmp("célestin  le ptit coquin","célestin  le petit coquin"));
	//printf("strcmp:		%d\nft_strcmp:	%d\n__\n",ft_strcmp(NULL, NULL),ft_strcmp(NULL, NULL));
    return(0);
}

int     test_strdup(void)
{
    printf("\n");
    printf("------------------------------------------\n");
    printf("*               test_strdup              *\n");
    printf("------------------------------------------\n");
    char *a = "bonjour les petits enfants";
    char *b = "";
    char *d = "hey";

    char *new_a = strdup(a);
    char *new_b = strdup(b);
    char *new_d = strdup(d);
    char *ft_new_a = ft_strdup(a);
    char *ft_new_b = ft_strdup(b);
    char *ft_new_d = ft_strdup(d);

    // strdup (strdup with a NULL string is undefined)
    printf("strdup:		%s\nft_strdup:	%s\n__\n", new_a, ft_new_a);
    printf("strdup:		%s\nft_strdup:	%s\n__\n", new_b, ft_new_b);
    printf("strdup:		%s\nft_strdup:	%s\n__\n", new_d, ft_new_d);
    free(new_a);
    free(new_b);
    free(new_d);
    free(ft_new_a);
    free(ft_new_b);
    free(ft_new_d);

    return(0);
}

int     test_read(void)
{
    printf("\n");
    printf("------------------------------------------\n");
    printf("*                test_read               *\n");
    printf("------------------------------------------\n");
    int bufferlen = 50;
    int fd_1 = open("src/ft_write.s", O_RDONLY);
    int fd_ft_1 = open("src/ft_write.s", O_RDONLY);

    char buffer[bufferlen + 1];
    char ft_buffer[bufferlen + 1];
    buffer[bufferlen] = '\0';
    ft_buffer[bufferlen] = '\0';
    printf("read - %zd\n", read(fd_1, buffer, -5));
    printf("value of errno: %d\n", errno);
    printf("ft_read - %zd\n", ft_read(fd_ft_1, ft_buffer, -5));
    printf("value of errno: %d\n", errno);
    printf("read - %zd\n", read(fd_1, buffer, bufferlen));
    printf("ft_read - %zd\n", ft_read(fd_ft_1, ft_buffer, bufferlen));
    return(0);
}

int     test_write(void)
{
    printf("\n");
    printf("------------------------------------------\n");
    printf("*               test_write               *\n");
    printf("------------------------------------------\n");
    char *a = "bonjour les petits enfants";
    char *b = "";
    char *c = NULL;
    char *d = "hey";

    printf("\n");
    printf("write a:    ");
    printf("\n");
    write(1, a, strlen(a));
    printf("\n");
    printf("ft_write a:    ");
    printf("\n");
    ft_write(1, a, strlen(a));
    printf("\n");
    printf("write b:    ");
    printf("\n");
    write(1, b, strlen(b));
    printf("\n");
    printf("ft_write b:    ");
    printf("\n");
    ft_write(1, b, strlen(b));
    printf("\n");
    printf("write c:    ");
    printf("\n");
    write(1, c, 0);
    printf("\n");
    printf("ft_write c:    ");
    printf("\n");
    ft_write(1, c, 0);
    printf("\n");
    printf("write d:    ");
    printf("\n");
    write(1, d, strlen(d));
    printf("\n");
    printf("ft_write d:    ");
    printf("\n");
    ft_write(1, d, strlen(d));
    printf("\n");
    return(0);
}

int     main(void)
{
    test_strlen();
    test_strcpy();
    test_strcmp();
    test_strdup();
    test_read();
    test_write();
    return(0);
}

int     nothing(void)
{
    char *a = "bonjour les petits enfants";
    char *b = "";
    // char *c = NULL;
    char *d = "hey";


	//strcmp
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("hey",""),ft_strcmp("hey",""));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("célestin  le peetit coquin","célestin  le petit coquin"),ft_strcmp("célestin  le peetit coquin","célestin  le petit coquin"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("célestin  le petit coquin","célestin  le petit coquin"),ft_strcmp("célestin  le petit coquin","célestin  le petit coquin"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("ho","ho"),ft_strcmp("ho","ho"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("",""),ft_strcmp("",""));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("hey","ho"),ft_strcmp("hey","ho"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",strcmp("célestin  le ptit coquin","célestin  le petit coquin"),ft_strcmp("célestin  le ptit coquin","célestin  le petit coquin"));
	printf("strcmp:		%d\nft_strcmp:	%d\n__\n",ft_strcmp(NULL, NULL),ft_strcmp(NULL, NULL));

	//strdup
	printf("strdup:		%s\nft_strdup:	%s\n__\n", strdup(a), ft_strdup(a));
	printf("strdup:		%s\nft_strdup:	%s\n__\n", strdup(b), ft_strdup(b));
	//printf("strdup:		%s\n__\nft_strdup:	%s\n", strdup(a), ft_strdup(a));
	printf("strdup:		%s\nft_strdup:	%s\n__\n", strdup(d), ft_strdup(d));
    return(0);
}
