#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <string.h>
#include <wait.h>

#define MAX_LEN 30

int main() {
    int pipe12[2], pipe13[2]; // Pipes: 1->2 and 1->3
    pid_t p2, p3;

    pipe(pipe12);
    pipe(pipe13);

    if ((p2 = fork()) == 0) {
        close(pipe12[1]); // close write
        char buffer[MAX_LEN];
        int n = read(pipe12[0], buffer, MAX_LEN);
        buffer[n] = '\0';
        printf("Digits: %s\n", buffer);
        close(pipe12[0]);
        exit(0);
    }

    // Fork Process 3
    if ((p3 = fork()) == 0) {
        close(pipe13[1]); // close write
        char buffer[MAX_LEN];
        int n = read(pipe13[0], buffer, MAX_LEN);
        buffer[n] = '\0';

        for (int i = 0; buffer[i]; ++i) {
            buffer[i] = toupper((unsigned char)buffer[i]);
        }

        printf("Uppercase Letters: %s\n", buffer);
        close(pipe13[0]);
        exit(0);
    }

    // Parent Process (Process 1)
    close(pipe12[0]);
    close(pipe13[0]);

    char line[MAX_LEN + 1];
    printf("Enter a line (max 30 chars): ");
    fgets(line, sizeof(line), stdin);

    char digits[MAX_LEN] = {0}, letters[MAX_LEN] = {0};
    int d = 0, l = 0;
    for (int i = 0; line[i]; ++i) {
        if (isdigit(line[i])) digits[d++] = line[i];
        else if (isalpha(line[i])) letters[l++] = line[i];
    }

    write(pipe12[1], digits, strlen(digits));
    write(pipe13[1], letters, strlen(letters));

    close(pipe12[1]);
    close(pipe13[1]);

    wait(NULL); wait(NULL); //asteapta sa treaca copiii strada

    return 0;
}
