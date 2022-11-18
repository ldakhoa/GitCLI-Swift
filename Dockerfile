ARG BUILDER_IMAGE=swift:5.7.0-focal
ARG RUNTIME_IMAGE=ubuntu:focal

# builder image
FROM ${BUILDER_IMAGE} AS builder
RUN apt-get && apt-get install -y make && rm -r /var/lib/apt/lists/*
WORKDIR /workdir/

COPY Sources Sources/
COPY Tests Tests/
COPY Makefile Makefile
COPY Package.* ./

RUN make build

# runtime image
FROM RUNTIME_IMAGE
LABEL org.opencontainers.image.source https://github.com/ldakhoa/GitCLI-Swift

RUN gitswift --version
