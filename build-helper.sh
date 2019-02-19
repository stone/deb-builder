#!/bin/bash -e

# This script is executed within the container as root.  
# It assumes
# that source code with debian packaging files can be found at
#   - /source-ro and 
# that resulting packages are written to 
#   - /output 
# after succesful build.
# These directories are mounted as docker volumes to
# allow files to be exchanged between the host and the container.

# Install extra dependencies that were provided for the build (if any)
[[ -d /dependencies ]] && dpkg -i /dependencies/*.deb || apt-get -f install -y --no-install-recommends

# Run pre tasks if any
[[ -d /prerun.d ]] && run-parts -v /prerun.d

# Make read-write copy of source code
mkdir -p /build
cp -a /source-ro /build/source
cd /build/source

# Install build dependencies
mk-build-deps -ir -t "apt-get -o Debug::pkgProblemResolver=yes -y --no-install-recommends"

# Build packages
debuild -b -uc -us

# Copy packages to output dir with user's permissions
chown -R $USER:$GROUP /build
cp -a /build/* /output/

# Run post tasks if any
[[ -d /postrun.d ]] && run-parts -v /postrun.d

