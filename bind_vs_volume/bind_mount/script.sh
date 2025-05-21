#!/bin/bash
# BIND MOUNT EXAMPLE
# This script demonstrates how to use Docker bind mounts

# Set -e to exit on error
set -e

# Function to wait for user to press Enter
wait_for_user() {
  echo ""
  read -p "Press Enter to continue to the next step..." </dev/tty
  echo ""
}

echo "===== DOCKER BIND MOUNT DEMONSTRATION ====="
echo "This script will guide you through Docker bind mounts."
echo "You can press Enter after each step to continue."
echo ""
wait_for_user

# STEP 1: Create a directory on the host to mount into containers
echo "STEP 1: Creating a directory on the host to mount into containers"
mkdir -p ~/bind_data
echo "✓ Created directory: ~/bind_data"
wait_for_user

# STEP 2: Create some sample data in the host directory
echo "STEP 2: Creating sample data in the host directory"
echo "This file was created on the host" > ~/bind_data/host_file.txt
echo "✓ Created file: ~/bind_data/host_file.txt"
echo "✓ File content:"
cat ~/bind_data/host_file.txt
wait_for_user

# STEP 3: Run a container with a bind mount
echo "STEP 3: Running a container with a bind mount"
# Remove container if it already exists
docker rm -f bind-example 2>/dev/null || true
docker run -d --name bind-example \
  -v ~/bind_data:/container_data \
  alpine:latest \
  tail -f /dev/null
echo "✓ Container 'bind-example' started with bind mount"
wait_for_user

# STEP 4: Verify the host file is accessible from the container
echo "STEP 4: Verifying the host file is accessible from the container"
echo "✓ Files in /container_data inside the container:"
docker exec bind-example ls -la /container_data
echo ""
echo "✓ Content of host_file.txt from container:"
docker exec bind-example cat /container_data/host_file.txt
wait_for_user

# STEP 5: Create a file from the container and verify it appears on the host
echo "STEP 5: Creating a file from the container and verifying it appears on the host"
docker exec bind-example sh -c 'echo "This file was created in the container" > /container_data/container_file.txt'
echo "✓ Created file from container"
echo ""
echo "✓ Files in ~/bind_data on host:"
ls -la ~/bind_data
echo ""
echo "✓ Content of container_file.txt on host:"
cat ~/bind_data/container_file.txt
wait_for_user

# STEP 6: Modify the file on the host and verify changes in container
echo "STEP 6: Modifying a file on the host and verifying changes in container"
echo "Adding a new line from the host" >> ~/bind_data/container_file.txt
echo "✓ Modified file on host"
echo ""
echo "✓ Updated content seen from container:"
docker exec bind-example cat /container_data/container_file.txt
wait_for_user

# STEP 7: Key characteristics of bind mounts
echo "STEP 7: Key characteristics of bind mounts"
echo "KEY CHARACTERISTICS OF BIND MOUNTS:"
echo "* Bind mounts map a host directory or file directly into a container"
echo "* Changes made in either the host or container are immediately visible to the other"
echo "* The host path must be an absolute path"
echo "* Good for development where you need to edit files on the host and see changes in the container"
echo "* If the host directory doesn't exist, Docker will create it automatically"
echo "* Command syntax: docker run -v /host/path:/container/path ..."
wait_for_user

# STEP 8: Cleanup
echo "STEP 8: Cleanup"
echo "Stopping and removing container..."
docker stop bind-example
docker rm bind-example
echo "✓ Container removed"
echo ""
echo "Removing bind mount directory..."
rm -rf ~/bind_data
echo "✓ Bind mount directory removed"
echo ""

echo "===== BIND MOUNT DEMONSTRATION COMPLETE =====" 