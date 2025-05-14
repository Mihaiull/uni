// Compute the sum of an array of numbers using divide et impera method:
// a process splits the array in two sub-arrays and gives them to two other chid processes to compute their sums, then adds the results obtained.
// The child processes use the same technique (split, etc. …).

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

// Reads integers from file into an array
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

// Recursive sum using processes
int process_sum(int *arr, int start, int end) {
    if (start == end) {
        // Base case: one element
        return arr[start];
    }

    int mid = (start + end) / 2;

    int pipefd1[2], pipefd2[2];
    pipe(pipefd1);
    pipe(pipefd2);

    pid_t left_pid = fork();
    if (left_pid == 0) {
        // Left child process
        int sum = process_sum(arr, start, mid);
        close(pipefd1[0]);
        write(pipefd1[1], &sum, sizeof(int));
        close(pipefd1[1]);
        exit(0);
    }

    pid_t right_pid = fork();
    if (right_pid == 0) {
        // Right child process
        int sum = process_sum(arr, mid + 1, end);
        close(pipefd2[0]);
        write(pipefd2[1], &sum, sizeof(int));
        close(pipefd2[1]);
        exit(0);
    }

    // Parent process
    close(pipefd1[1]);
    close(pipefd2[1]);
    int left_sum, right_sum;
    read(pipefd1[0], &left_sum, sizeof(int));
    read(pipefd2[0], &right_sum, sizeof(int));
    close(pipefd1[0]);
    close(pipefd2[0]);

    wait(NULL);
    wait(NULL);

    return left_sum + right_sum;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    int arr[1000];
    int n = read_numbers(argv[1], arr);

    int total_sum = process_sum(arr, 0, n - 1);
    printf("Total sum: %d\n", total_sum);

    return 0;
}
