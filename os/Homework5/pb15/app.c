//Write a C Program that counts the number of letters on each line of a text file. Make no assumptions regarding the maximum length of a line.

#include <stdio.h>

int main(int argc, char *argv[]){
    // Check if the file name is provided as a command line argument
    if (argc != 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    // Open the file in read mode
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    char line[1024]; // Buffer to store each line
    int lineNumber = 0;

    // Read the file line by line
    while (fgets(line, sizeof(line), file)) {
        lineNumber++;
        int letterCount = 0;

        // Count letters in the current line
        for (int i = 0; line[i] != '\0'; i++) {
            if ((line[i] >= 'A' && line[i] <= 'Z') || (line[i] >= 'a' && line[i] <= 'z')) {
                letterCount++;
            }
        }

        // Print the number of letters in the current line
        printf("Line %d: %d letters\n", lineNumber, letterCount);
    }

    // Close the file
    fclose(file);

    return 0;
}
