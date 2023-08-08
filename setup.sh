# check if directory contains lib/gemini
if [ -f lib/gemini/gemini.go ]; then
#     Compile gemini
    cd lib/gemini
    go build -o libgemini.so -buildmode=c-shared gemini.go
    if [ -f libgemini.so ]; then
        echo "Gemini support compiled"
    else
#         Abort
        echo "Failed to compile Gemini support"
        exit
    fi
    cd ..
else
#     Abort
    echo "lib/gemini/gemini.go not found, are you running in the right directory?"
    exit
fi

cd gopher
gcc -shared -o libgopher.so gopher.c

if [ -f libgopher.so ]; then
    echo "Gopher support compiled"
    cd ..
else
#     Abort
    echo "Failed to compile Gopher support"
    exit
fi

cd twt_hash
go build -o libtwthash.so --buildmode=c-shared twthash.go

if [ -f libtwthash.so ]; then
    echo "Twt hash support compiled"
    cd ../..
else
#     Abort
    echo "Failed to compile Twt hash support"
    exit
fi

cd db
go build setup.go
if [ -f setup ]; then
    echo "DB setup complete"
    ./setup
    cd ..
else
#     Abort
    echo "Failed to setup DB"
    exit
fi

echo "Running tests.."
if bundle exec rspec; then
    echo "Tests passed! You're good to go!"
else
    echo "Tests failed. Something must have gone wrong during setup."
    exit
fi
