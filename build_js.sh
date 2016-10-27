#!/bin/sh

# For this script to work you must have emscripten configured in your shell.
# See http://kripken.github.io/emscripten-site/docs/getting_started/downloads.html

CONFIGURE_FLAGS=--prefix=/usr --without-async --without-mbrola --without-sonic

# First, we configure for a native build
./configure $(CONFIGURE_FLAGS) &&
# Do a native build to create data files
make &&
# Re-configure for emscripten
emconfigure ./configure $(CONFIGURE_FLAGS) &&
# Build espeak-ng library as LLVM IR code.
emmake make src/libespeak-ng.la &&
# Create Javascript espeak-ng worker.
emmake make -C emscripten
