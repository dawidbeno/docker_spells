FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    software-properties-common

# Install NVIDIA Container Toolkit
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
    && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

RUN apt-get update && \
    apt-get install -y nvidia-container-toolkit

# Clean up to reduce image size
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the default command
CMD ["/bin/bash"]