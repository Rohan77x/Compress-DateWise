#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <target_directory>"
    exit 1
fi

# Source and destination directories from command-line arguments
SOURCE_DIR=$1
TARGET_DIR=$2

# Ensure the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist."
    exit 1
fi

# Ensure the target directory exists, if not, create it
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

# Function to compress each file with its modification date and time
compress_files() {
    cd "$SOURCE_DIR" || exit
    for file in *; do
        if [ -f "$file" ]; then
            mod_date=$(date -r "$file" +"%Y-%m-%d_%H-%M-%S")
            tar -czf "$TARGET_DIR/${file}_${mod_date}.tar.gz" "$file"
        fi
    done
}

# Execute the compression function
compress_files

echo "Compression complete."
