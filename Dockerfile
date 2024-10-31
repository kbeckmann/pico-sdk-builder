FROM ubuntu:24.04

# Set the working directory
WORKDIR /opt

# Install necessary packages and clean up afterwards
RUN apt update && \
    apt -y upgrade && \
    apt install -y cmake python3 git gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi && \
    rm -rf /var/lib/apt/lists/*

# Download the pico-sdk
RUN git clone --depth 1 https://github.com/raspberrypi/pico-sdk && \
    cd pico-sdk && git submodule update --init

# Set environment variable for the pico-sdk path
ENV PICO_SDK_PATH=/opt/pico-sdk

# Default command
CMD ["/bin/bash"]
