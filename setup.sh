#!/bin/bash

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -a, --all               Perform all actions"
    echo "  -g, --compile-gemini    Compile Gemini support"
    echo "  -o, --compile-gopher    Compile Gopher support"
    echo "  -t, --compile-twthash   Compile Twt hash support"
    echo "  -d, --setup-db          Set up DB"
    echo "  -r, --run-tests         Run tests"
    echo "  -h, --help              Show this help message"
    exit 0
}

# Parse command-line arguments
compile_gemini=false
compile_gopher=false
compile_twthash=false
setup_db=false
run_tests=false

# Check if no arguments were provided
if [ $# -eq 0 ]; then
    usage
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        -a | --all)
            compile_gemini=true
            compile_gopher=true
            compile_twthash=true
            setup_db=true
            run_tests=true
            shift
            ;;
        -g | --compile-gemini)
            compile_gemini=true
            shift
            ;;
        -o | --compile-gopher)
            compile_gopher=true
            shift
            ;;
        -t | --compile-twthash)
            compile_twthash=true
            shift
            ;;
        -d | --setup-db)
            setup_db=true
            shift
            ;;
        -r | --run-tests)
            run_tests=true
            shift
            ;;
        -h | --help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done
# Compile Gemini support
if [ "$compile_gemini" = true ]; then
    if [ -f lib/gemini/gemini.go ]; then
        echo "Compiling Gemini support..."
        cd lib/gemini
        go build -o libgemini.so -buildmode=c-shared gemini.go
        if [ -f libgemini.so ]; then
            echo "Gemini support compiled"
        else
            echo "Failed to compile Gemini support"
            exit 1
        fi
        cd ../..
    else
        echo "Error: lib/gemini/gemini.go not found. Make sure you're in the right directory."
        exit 1
    fi
fi

# Compile Gopher support
if [ "$compile_gopher" = true ]; then
    echo "Compiling Gopher support..."
    cd lib/gopher
    gcc -shared -o libgopher.so gopher.c
    if [ -f libgopher.so ]; then
        echo "Gopher support compiled"
        cd ../..
    else
        echo "Failed to compile Gopher support"
        exit 1
    fi
fi

# Compile Twt hash support
if [ "$compile_twthash" = true ]; then
    echo "Compiling Twt hash support..."
    cd lib/twt_hash
    go build -o libtwthash.so --buildmode=c-shared twthash.go
    if [ -f libtwthash.so ]; then
        echo "Twt hash support compiled"
        cd ../..
    else
        echo "Failed to compile Twt hash support"
        exit 1
    fi
fi

# Set up DB
if [ "$setup_db" = true ]; then
    echo "Setting up DB..."
    cd db
    go build setup.go
    if [ -f setup ]; then
        ./setup
        echo "DB setup complete"
        rm setup
        cd ..
    else
        echo "Failed to set up DB"
        exit 1
    fi
fi

# Run tests
if [ "$run_tests" = true ]; then
    echo "Running tests..."
    if bundle exec rspec; then
        echo "Tests passed! You're good to go!"
    else
        echo "Tests failed. Something must have gone wrong during setup."
        exit 1
    fi
fi

exit 0
