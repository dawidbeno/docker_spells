# GPU Support in docker
This is example of how to run docker container with GPU support.

I experienced a situation having custom docker image and the need of GPU support. I had to run application that uses GPU.
Luckily, my machine has NVIDIA GPU and I can use it with docker.

## Install nvidia container toolkit
1. Configure repository
```
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

2. Update packages
```
sudo apt-get update
```

3. Install the NVIDIA Container Toolkit packages
```
sudo apt-get install -y nvidia-container-toolkit
```

## Build & run docker container
1. Build docker image
```
docker build -t test-gpu .
```

2. Run container
```
docker run --gpus all test-gpu nvidia-smi
```

## References
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
- [Docker GPU Support](https://docs.nvidia.com/ai-enterprise/deployment/vmware/latest/docker.html)
- [Use the GPU in Docker](https://blog.roboflow.com/use-the-gpu-in-docker/)
