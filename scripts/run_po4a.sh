#!/bin/bash

# fix for MSYS2/Git Bash on Windows
export MSYS2_ARG_CONV_EXCL=*

# Check if the po4a image exists
if ! docker image inspect po4a >/dev/null 2>&1; then
    echo "Building po4a Docker image..."
    docker build -t po4a -f Dockerfile.po4a \
        --build-arg USER_ID=$(id -u) \
        --build-arg GROUP_ID=$(id -g) .
fi

# Run po4a and capture output
output=$(docker run --rm \
    -v "$(pwd):/workspace" \
    -w /workspace \
    --user $(id -u):$(id -g) \
    po4a -c "po4a $*" 2>&1)
exit_code=$?

# If po4a failed and the error contains a command that exited with value
if [ $exit_code -ne 0 ] && echo "$output" | grep -q "exited with value"; then
    echo "po4a failed. message:"
    echo "$output"
    echo "Running failed command with verbose output for more details..."
    echo "----------------------------------------"
    # Extract the command from between single quotes
    failed_cmd=$(echo "$output" | grep -o "'[^']*'" | head -n 1 | sed "s/'//g")
    if [ -n "$failed_cmd" ]; then
        echo "Running command: $failed_cmd --verbose"
        docker run --rm \
            -v "$(pwd):/workspace" \
            -w /workspace \
            --user $(id -u):$(id -g) \
            po4a -c "$failed_cmd --verbose"
    else
        echo "Could not extract command from error message"
        echo "$output"
    fi
    echo "----------------------------------------"
    exit $exit_code
fi

# If no command error or no command found, just show the original output
echo "$output"
exit $exit_code