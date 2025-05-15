#!/bin/bash
# Activate virtual environment (optional, uncomment and update path if needed)
# source venv/bin/activate

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to check if a Python command is Python 3.x
is_python3() {
    local python_cmd="$1"
    local version
    version=$($python_cmd --version 2>&1)
    if [[ $version == *"Python 3"* ]]; then
        return 0
    else
        return 1
    fi
}

# Check for python3 or python command
if command_exists python3 && is_python3 python3; then
    PYTHON=python3
elif command_exists python && is_python3 python; then
    PYTHON=python
else
    echo "Error: No Python 3 interpreter found (neither 'python' nor 'python3' is Python 3.x)."
    exit 1
fi

# Ensure prediction.py exists
if [ ! -f "prediction.py" ]; then
    echo "Error: prediction.py not found in the current directory."
    exit 1
fi

# Install dependencies if requirements.txt exists
if [ -f "requirements.txt" ]; then
    $PYTHON -m pip install -r requirements.txt
fi

# Run the script with any provided arguments
$PYTHON prediction.py "$@"