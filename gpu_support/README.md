# GPU Support in docker
This is example of how to run docker container with GPU support.

I experienced situation having custom docker image and the need of GPU support. I had to run application that uses GPU.
Luckily, my machine has NVIDIA GPU and I can use it with docker.

Build docker image
```
docker build -t minimal-nvidia .
```

Run container
```
docker run --gpus all minimal-nvidia nvidia-smi
```

## References
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
- [Docker GPU Support](https://docs.nvidia.com/ai-enterprise/deployment/vmware/latest/docker.html)
- [Use the GPU in Docker](https://blog.roboflow.com/use-the-gpu-in-docker/)
