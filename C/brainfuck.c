#include <stdlib.h>
#include <stdio.h>

const int CELLS = 30000;
char* memory;
char* ptr_memory;
FILE* source;

void ptr_increment()
{
    ptr_memory++;
}

void ptr_decrement()
{
    ptr_memory--;
}

void mem_increment()
{
    (*ptr_memory)++;
}

void mem_decrement()
{
    (*ptr_memory)--;
}

void mem_output()
{
    putchar(*ptr_memory);
}

void mem_input()
{
    *ptr_memory = getchar();
}

void start_match()
{
    if (!(*ptr_memory))
    {
        while (fgetc(source) != ']');
    }
}

void end_match()
{
    if (*ptr_memory)
    {
        int nesting = 1;
        char command;
        while (nesting)
        {
            fseek(source, -2, SEEK_CUR);
            command = fgetc(source);
            switch(command)
            {
                case '[':
                    nesting--;
                    break;
                case ']':
                    nesting++;
                    break;
            }
        }
    }
}

int main(int argc, char* argv[])
{
    if (argc < 2)
    {
        // TODO: EXPAND
        printf("WRONG USAGE\n");
        return -1;
    }

    source = fopen(argv[1], "r+");
    if (source)
    {
        memory = malloc(CELLS);
        ptr_memory = memory;
        char command;
        do
        {
            command = fgetc(source);
            switch (command)
            {
                case '>':
                    ptr_increment();
                    break;
                case '<':
                    ptr_decrement();
                    break;
                case '+':
                    mem_increment();
                    break;
                case '-':
                    mem_decrement();
                    break;
                case '.':
                    mem_output();
                    break;
                case ',':
                    mem_input();
                    break;
                case '[':
                    start_match();
                    break;
                case ']':
                    end_match();
                    break;
            }
        } while (command != EOF);
        fclose(source);
    }
    else
    {
        // TODO: EXPAND
        printf("NONEXISTANT FILE\n");
        return -1;
    }

    return 0;
}
