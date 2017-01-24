#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

typedef struct Board {
    size_t width;
    size_t height;
    bool* matrix;
} Board;

int main(int argc, char* argv[argc + 1]) {
    printf("%s\n", argv[0]);
    return 0;
}
