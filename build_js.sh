#!/bin/sh

# For this script to work you must have emscripten configured in your shell.
# See http://kripken.github.io/emscripten-site/docs/getting_started/downloads.html

# Configure for a native build.
./configure --prefix=/usr --without-async --without-mbrola --without-sonic &&

# Do a native build to compile data files.
if [ "$#" -lt 1 ]
then
    # No arguments: compile data for all languages.
    make
else
    # One or more arguments: compile data for the specified languages.
    for arg in "$@"
    do
        make "$arg"
    done
fi

# Re-configure for emscripten.
emconfigure ./configure --prefix=/usr --without-async --without-mbrola --without-sonic &&

# Build espeak-ng library as LLVM IR code.
emmake make src/libespeak-ng.la &&

# Create Javascript espeak-ng worker.
emmake make -C emscripten
