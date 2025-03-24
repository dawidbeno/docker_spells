FROM ros:jazzy-ros-base-noble

# Install only NVIDIA-related packages
RUN apt-get update && apt-get install -y \
    nvidia-cuda-toolkit \
    nvidia-cudnn

# Set the default command
CMD ["bash"]