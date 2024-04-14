#!/bin/bash

# Define the directory
DIR="$HOME/.config/nvim"

# Temporary file to hold the content
TEMP_FILE=$(mktemp)

# Check for clipboard utility and set the command to use
if command -v pbcopy > /dev/null; then
    COPY_CMD="pbcopy"
elif command -v xclip > /dev/null; then
    COPY_CMD="xclip -selection clipboard"
elif command -v xsel > /dev/null; then
    COPY_CMD="xsel --clipboard --input"
else
    echo "No clipboard utility found. Install pbcopy, xclip, or xsel."
    rm -f "$TEMP_FILE"
    exit 1
fi

# Find and concatenate all files in the directory, excluding certain directories and files
find "$DIR" -type f \
    ! -path '*/.git/*' \
    ! -path '*/node_modules/*' \
    ! -name 'lazy_lock.json' \
    ! -name 'LICENSE' \
    ! -name 'README.md' \
    -exec cat {} + > "$TEMP_FILE"

# Copy content to clipboard
cat "$TEMP_FILE" | $COPY_CMD

# Print the content to standard output
cat "$TEMP_FILE"
echo "Contents copied to clipboard."

# Remove the temporary file
rm -f "$TEMP_FILE"
