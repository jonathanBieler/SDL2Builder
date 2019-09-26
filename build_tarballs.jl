# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder
name = "SDL2"
version = v"0.1.0"

# Collection of sources required to build SDL2
sources = [
    "https://libsdl.org/release/SDL2-2.0.10.zip" =>
    "658b0435f57d496e967c1996badbd83bac120689a693f57c4007698d0fe24543",
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd SDL2-2.0.10/
mkdir build
cd build
../configure --prefix=$prefix --host=$target
make -j${nproc}
make install
exit
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libSDL2", :libSDL2)
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
