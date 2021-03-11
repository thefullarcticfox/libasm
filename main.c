#include "libasm.h"
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

void	ft_error(void)
{
	if (errno != 0)
	{
		printf("errno: %d\n", errno);
		perror("Error");
		printf("\n", errno);
		errno = 0;
	}
}

void	write_check(char *s)
{
	int		fd;
	int		ret;

	printf("\n------\twrite to stdout\t------\n");
	ret = write(1, s, strlen(s));
	printf("\nwrite returned: %d\n", ret);
	ft_error();
	ret = ft_write(1, s, ft_strlen(s));
	printf("\nft_write returned: %d\n", ret);
	ft_error();
	if ((fd = open("test.txt", O_CREAT | O_WRONLY | O_TRUNC | O_APPEND,
		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)) < 0)
		return ;
	printf("\n------\twrite to fd = %d\t------\n", fd);
	ret = write(fd, s, strlen(s));
	printf("write returned: %d\n", ret);
	ft_error();
	ret = ft_write(fd, s, ft_strlen(s));
	printf("ft_write returned: %d\n", ret);
	if (!errno)
		printf("Check test.txt\nMust contain this:\n|%s%s|\n", s, s);
	ft_error();
	close(fd);
}

void	readfile_check(void)
{
	char	str[41];
	int		fd;
	int		ret;

	if ((fd = open("libasm.h", O_RDONLY)) < 0)
		return ;
	printf("\n------\tread fd = %d\t------\n", fd);
	ret = read(fd, str, 40);
	if (ret < 0)
		bzero(str, 40);
	else
		str[ret] = 0;
	printf("|%s|\nread returned: %d\n", str, ret);
	ft_error();
	close(fd);
	if ((fd = open("libasm.h", O_RDONLY)) < 0)
		return ;
	ret = ft_read(fd, str, 40);
	if (ret < 0)
		bzero(str, 40);
	else
		str[ret] = 0;
	printf("|%s|\nft_read returned: %d\n", str, ret);
	ft_error();
	close(fd);
}

void	syscall_check(char *s)
{
	int		ret;
	char	str[41];

	write_check(s);
	readfile_check();
	printf("\n------\tread from stdin\t------\n");
	ret = read(0, str, 40);
	str[ret] = 0;
	printf("|%s|\nread returned: %d\n", str, ret);
	ret = ft_read(0, str, 40);
	str[ret] = 0;
	printf("|%s|\nft_read returned: %d\n", str, ret);
}

int		main(void)
{
	char	*str[2];
	char	cpy[2][1000];
	char	*dup[2];

	str[0] = "123";
	str[1] = "1234";
	printf("strlen\norig:\tmine:\n%lu\t%lu\n",
		strlen(str[0]), ft_strlen(str[0]));
	printf("\nstrcmp\norig:\tmine:\n%d\t%d\n",
		strcmp(str[0], str[1]), ft_strcmp(str[0], str[1]));
	strcpy(cpy[0], str[0]);
	ft_strcpy(cpy[1], str[0]);
	printf("\nstrcpy\norig:\n|%s|\nmine:\n|%s|\n", cpy[0], cpy[1]);
	printf("\nstrcpy in printf\norig:\n|%s|\nmine:\n|%s|\n",
		strcpy(cpy[0], str[0]), ft_strcpy(cpy[1], str[0]));
	dup[0] = strdup(str[0]);
	ft_error();
	dup[1] = ft_strdup(str[0]);
	ft_error();
	printf("\nstrdup\norig:\n|%s|\nmine:\n|%s|\n", dup[0], dup[1]);
	free(dup[0]);
	free(dup[1]);
	printf("Free worked (no sigabort)\n");
	syscall_check(str[0]);
	return (0);
}
