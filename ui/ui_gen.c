#include <stdio.h>

int main(int argc, char **argv)
{
    int max;
    int count;
    char *ptr;
    max = 0;
    // printf ("There are %d args\n", argc - 1);
    for (int i=1; i<argc; i++) {
        count = 0;
        ptr = argv[i];
        while(*ptr != '\0') {
            // printf ("%c", *ptr);
            ptr++;
            count++;
        }
        if (count > max)
            max = count;
        // puts ("");
    }
    // printf ("Max len: %d\n", max);

// ==================================
//
    printf ("/");
    for (int i=0; i<max+2; i++)
        printf ("=");
    printf ("\\\n");
    for (int i=1; i<argc; i++) {
        count = 0;
        printf ("| ");
        ptr = argv[i];
        while (*ptr != '\0') {
            printf ("%c", *ptr);
            ptr++;
            count++;
        }
        for (; count < max; count++)
            printf (" ");
        printf (" |\n");
    }
    printf ("\\");
    for (int i=0; i<max+2; i++)
        printf ("=");
    printf ("/\n");
    return 0;
}
