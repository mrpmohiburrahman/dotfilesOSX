# add_path_comments.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Determine the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR"

# Function to pick comment syntax based on file extension
get_comment_syntax() {
    local ext="$1"
    case "$ext" in
    # C-style line comments
    ts | tsx | js | jsx | c | cpp | h | hpp)
        PREFIX="//"
        SUFFIX=""
        ;;
    # Shell/Python/Ruby/Perl/YAML/INI/Lua
    sh | bash | py | rb | pl | yaml | yml | ini | conf | lua)
        PREFIX="#"
        SUFFIX=""
        ;;
    # HTML/XML
    html | htm | xml)
        PREFIX="<!--"
        SUFFIX="-->"
        ;;
    # CSS/LESS/SCSS
    css | less | scss)
        PREFIX="/*"
        SUFFIX="*/"
        ;;
    # SQL
    sql)
        PREFIX="--"
        SUFFIX=""
        ;;
    lua)
        PREFIX="--"
        SUFFIX=""
        ;;
    # Default to shell-style

    *)
        PREFIX="--"
        SUFFIX=""
        ;;
    esac
}

# Function to add comment to a file
add_comment() {
    local file="$1"
    local rel_path="${file#./}"
    local ext="${file##*.}"

    get_comment_syntax "$ext"
    local comment_line
    if [ -n "$SUFFIX" ]; then
        comment_line="${PREFIX} ${rel_path} ${SUFFIX}"
    else
        comment_line="${PREFIX} ${rel_path}"
    fi

    if head -n 1 "$file" | grep -Fxq "$comment_line"; then
        echo "✔️  Already commented: $file"
        return
    fi

    tmp=$(mktemp)
    {
        echo "$comment_line"
        cat "$file"
    } >"$tmp"
    mv "$tmp" "$file"
    echo "➕ Added comment to $file"
}

export -f add_comment get_comment_syntax

echo "🔍 Searching for files to process in $SCRIPT_DIR..."

# Count total up front
total=$(find . \
    -type d -name "node_modules" -prune -o \
    -type f \( \
    -iname "*.ts" -o -iname "*.tsx" \
    -o -iname "*.js" -o -iname "*.jsx" \
    -o -iname "*.sh" -o -iname "*.py" \
    -o -iname "*.lua" \
    -o -iname "*.html" -o -iname "*.css" \
    -o -iname "*.yaml" -o -iname "*.yml" \
    \) -print | wc -l)
echo "🗂️  Total files to process: $total"

# Iterate with null-delimited safety
count=0
find . \
    -type d -name "node_modules" -prune -o \
    -type f \( \
    -iname "*.ts" -o -iname "*.tsx" \
    -o -iname "*.js" -o -iname "*.jsx" \
    -o -iname "*.sh" -o -iname "*.py" \
    -o -iname "*.lua" \
    -o -iname "*.html" -o -iname "*.css" \
    -o -iname "*.yaml" -o -iname "*.yml" \
    \) -print0 |
    while IFS= read -r -d '' file; do
        ((count++))
        echo "Processing ($count/$total): $file"
        add_comment "$file"
    done
echo "🎉 Done! All files are commented appropriately."
