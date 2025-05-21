#!/bin/bash
# DOCKER VOLUME EXAMPLE
# This script demonstrates how to use Docker volumes

# Set -e to exit on error
set -e

# Function to wait for user to press Enter
wait_for_user() {
  echo ""
  read -p "Press Enter to continue to the next step..." </dev/tty
  echo ""
}

echo "===== DOCKER VOLUME DEMONSTRATION ====="
echo "This script will guide you through Docker volumes."
echo "You can press Enter after each step to continue."
echo ""
wait_for_user

# STEP 1: Create a Docker volume
echo "STEP 1: Creating a Docker volume"
docker volume create my_data_volume
echo "✓ Volume 'my_data_volume' created"
echo "✓ Listing available volumes:"
docker volume ls
wait_for_user

# STEP 2: Run a container with the volume
echo "STEP 2: Running a container with the volume"
# Remove container if it already exists
docker rm -f volume-example1 2>/dev/null || true
docker run -d --name volume-example1 \
  -v my_data_volume:/container_data \
  alpine:latest \
  tail -f /dev/null
echo "✓ Container 'volume-example1' started with volume"
wait_for_user

# STEP 3: Create data in the volume from the first container
echo "STEP 3: Creating data in the volume from the first container"
docker exec volume-example1 sh -c 'echo "Data created from container 1" > /container_data/file1.txt'
echo "✓ Created file in volume from container 1"
echo "✓ Listing files in volume:"
docker exec volume-example1 ls -la /container_data
echo ""
echo "✓ Content of file1.txt:"
docker exec volume-example1 cat /container_data/file1.txt
wait_for_user

# STEP 4: Run a second container with the same volume
echo "STEP 4: Running a second container with the same volume"
# Remove container if it already exists
docker rm -f volume-example2 2>/dev/null || true
docker run -d --name volume-example2 \
  -v my_data_volume:/container_data \
  alpine:latest \
  tail -f /dev/null
echo "✓ Container 'volume-example2' started with the same volume"
wait_for_user

# STEP 5: Verify the second container can access the data
echo "STEP 5: Verifying the second container can access the data"
echo "✓ Files in volume from container 2:"
docker exec volume-example2 ls -la /container_data
echo ""
echo "✓ Content of file1.txt from container 2:"
docker exec volume-example2 cat /container_data/file1.txt
wait_for_user

# STEP 6: Add more data from the second container
echo "STEP 6: Adding more data from the second container"
docker exec volume-example2 sh -c 'echo "Data created from container 2" > /container_data/file2.txt'
echo "✓ Created file2.txt from container 2"
wait_for_user

# STEP 7: Check that the first container can see the data from the second
echo "STEP 7: Checking that the first container can see the data from the second"
echo "✓ Files in volume from container 1:"
docker exec volume-example1 ls -la /container_data
echo ""
echo "✓ Content of file2.txt from container 1:"
docker exec volume-example1 cat /container_data/file2.txt
wait_for_user

# STEP 8: Inspect volume information
echo "STEP 8: Inspecting volume information"
echo "✓ Volume details:"
docker volume inspect my_data_volume
wait_for_user

# STEP 9: Stop and remove containers but keep the volume
echo "STEP 9: Stopping and removing containers but keeping the volume"
docker stop volume-example1 volume-example2
docker rm volume-example1 volume-example2
echo "✓ Containers removed"
wait_for_user

# STEP 10: Create a new container and verify data persists
echo "STEP 10: Creating a new container and verifying data persists"
docker run -d --name volume-example3 \
  -v my_data_volume:/container_data \
  alpine:latest \
  tail -f /dev/null
echo "✓ New container 'volume-example3' started with the same volume"
echo ""
echo "✓ Files in volume from new container:"
docker exec volume-example3 ls -la /container_data
echo ""
echo "✓ Content of file1.txt from new container:"
docker exec volume-example3 cat /container_data/file1.txt
echo ""
echo "✓ Content of file2.txt from new container:"
docker exec volume-example3 cat /container_data/file2.txt
wait_for_user

# STEP 11: Key characteristics of Docker volumes
echo "STEP 11: Key characteristics of Docker volumes"
echo "KEY CHARACTERISTICS OF DOCKER VOLUMES:"
echo "* Volumes are completely managed by Docker"
echo "* Data is stored in a part of the host filesystem managed by Docker (/var/lib/docker/volumes/)"
echo "* Non-Docker processes should not modify this part of the filesystem"
echo "* Volumes are the best way to persist data in Docker"
echo "* Volumes can be more safely shared among multiple containers"
echo "* Volume drivers let you store volumes on remote hosts, in cloud providers, or encrypt contents"
echo "* New volumes can have content pre-populated by a container"
echo "* Command syntax: docker run -v volume_name:/container/path ..."
wait_for_user

# STEP 12: Cleanup
echo "STEP 12: Cleanup"
echo "Stopping and removing container..."
docker stop volume-example3
docker rm volume-example3
echo "✓ Container removed"
echo ""
echo "Removing volume..."
docker volume rm my_data_volume
echo "✓ Volume removed"
echo ""

echo "===== VOLUME DEMONSTRATION COMPLETE =====" 