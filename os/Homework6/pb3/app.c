//We have a file that contains N integer numbers. Using two types of processes
//(one for determining the minimum and the other to determine the maximum value from an array),
// write a program that determines the kth element in increasing order of the integer array, without sorting the array.
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <limits.h>

#define MAX_SIZE 1000

// Function to read numbers from a file
int read_numbers(const char *filename, int *arr) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Failed to open file");
        exit(1);
    }

    int count = 0;
    while (fscanf(file, "%d", &arr[count]) == 1) {
        count++;
    }

    fclose(file);
    return count;
}

// Forked process to find the next minimum > current_min
int find_next_min(int *arr, int n, int current_min) {
    int pipefd[2];
    pipe(pipefd);

    pid_t pid = fork();
    if (pid == 0) {
        // Child process
        close(pipefd[0]);
        int min = INT_MAX;
        for (int i = 0; i < n; i++) {
            if (arr[i] > current_min && arr[i] < min) {
                min = arr[i];
            }
        }
        write(pipefd[1], &min, sizeof(int));
        close(pipefd[1]);
        exit(0);
    } else {
        // Parent process
        close(pipefd[1]);
        int min;
        read(pipefd[0], &min, sizeof(int));
        close(pipefd[0]);
        wait(NULL);
        return min;
    }
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <k> <filename>\n", argv[0]);
        return 1;
    }

    int k = atoi(argv[1]);
    const char *filename = argv[2];

    //print for testing

    int arr[MAX_SIZE];
    int n = read_numbers(filename, arr);

    //don't you dare put duplicates in the file or the last number you'll see will be max int value
    if (k < 1 || k > n) {
        fprintf(stderr, "Error: k must be between 1 and %d\n", n);
        return 1;
    }

    int current_min = INT_MIN;
    int kth = INT_MIN;

    for (int i = 0; i < k; i++) {
        kth = find_next_min(arr, n, current_min);
        current_min = kth;
    }

    printf("The %d-th smallest element is: %d\n", k, kth);
    return 0;
}
