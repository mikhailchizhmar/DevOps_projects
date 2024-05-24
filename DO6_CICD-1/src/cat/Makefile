TARGET = s21_cat

CC = gcc -Werror -Wextra -Wall

all: s21_cat

clean:
	rm -rf *.o $(TARGET)

style:
	cp ../../materials/linters/.clang-format ./
	clang-format -style=Google -n *.c
	rm -rf .clang-format

s21_cat:
	$(CC) -o $(TARGET) s21_cat.c

rebuild: clean all

