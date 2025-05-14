//Write a C Program that deletes from a file the bytes from even offsets. The name of the file is provided as a command line argument.

#include <stdio.h>

int main(int argc, char *argv[]) {
    // Check if the file name is provided as a command line argument
    if (argc != 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    // Open the file in read mode
    FILE *file = fopen(argv[1], "rb");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    // Create a temporary file to store the modified content
    FILE *tempFile = fopen("tempfile", "wb");
    if (tempFile == NULL) {
        perror("Error creating temporary file");
        fclose(file);
        return 1;
    }

    // Read the file byte by byte and write only the bytes from odd offsets to the temporary file
    int byte;
    int offset = 0;
    while ((byte = fgetc(file)) != EOF) {
        if (offset % 2 != 0) { // Check if the offset is odd
            fputc(byte, tempFile);
        }
        offset++;
    }

    // Close the files
    fclose(file);
    fclose(tempFile);

    // Remove the original file
    if (remove(argv[1]) != 0) {
        perror("Error deleting original file");
        return 1;
    }

    // Rename the temporary file to the original file name
    if (rename("tempfile", argv[1]) != 0) {
        perror("Error renaming temporary file");
        return 1;
    }
}
