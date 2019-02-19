
# Docker image for building debian packages

Build docker base image:

    docker build -t deb-builder:18.04 -f Dockerfile-ubuntu-18.04 .
    docker build -t deb-builder:17.04 -f Dockerfile-ubuntu-17.04 .

    usage: build [options...] SOURCEDIR
    Options:
        -i IMAGE  Name of the docker image (including tag) to use as package build environment.
        -o DIR    Destination directory to store packages to.
        -d DIR    Directory that contains other deb packages that need to be installed before build.
        -r DIR    Directory of shell scripts to be run in the container before building.
        -k        Keep docker container after build.

    mkdir /tmp/deb
    ./build -i deb-builder:18.04 -o /tmp/deb -r example/prerun.d -p example/postrun.d  example/hello-2.10
    ls /tmp/deb
    hello_2.10-1_amd64.build
    hello_2.10-1_amd64.buildinfo
    hello_2.10-1_amd64.changes
    hello_2.10-1_amd64.deb
    hello-dbgsym_2.10-1_amd64.ddeb



