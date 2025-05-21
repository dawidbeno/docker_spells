# 🐳 Docker Storage: Bind Mounts vs Volumes

Interactive demonstrations of Docker's two primary data persistence methods.

## 📋 What's Inside

- **Bind Mount Demo**: Shows how to directly map host directories into containers
- **Volume Demo**: Demonstrates Docker-managed volumes for data persistence

## 🚀 Quick Start

```bash
# For bind mount demonstration
cd bind_vs_volume/bind_mount
chmod +x script.sh
./script.sh

# For volume demonstration
cd bind_vs_volume/volume
chmod +x script.sh
./script.sh
```

## 🔄 Key Differences

| Feature | Bind Mounts | Volumes |
|---------|-------------|---------|
| **Management** | Host filesystem | Docker managed |
| **Location** | Any host path | `/var/lib/docker/volumes/` |
| **Portability** | Less portable | More portable |
| **Modification** | Host or container | Container preferred |
| **Best for** | Development | Production |
| **Command** | `-v /host/path:/container/path` | `-v volume_name:/container/path` |

## 💡 When To Use What

**Use Bind Mounts When:**
- You need to share configuration files from the host
- You're developing code and need live updates
- You want direct access to files from both host and container

**Use Volumes When:**
- You need to share data between containers
- You want Docker to manage storage and backups
- You're deploying to production environments
- You need better performance with I/O intensive operations
