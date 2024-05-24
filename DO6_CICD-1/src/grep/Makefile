TARGET = s21_grep

CC = gcc -Werror -Wextra -Wall

all:
	$(CC) -o $(TARGET) grep.c ../common/arrays.c ../common/misc.c ../common/queue.c -lpcre

clean:
	rm -rf *.o $(TARGET)

style:
	cp ../../materials/linters/.clang-format ./
	clang-format -style=Google -n *.c
	rm -rf .clang-format

s21_grep: all

rebuild: clean all
