## First clone Kernel Tree
```
git clone https://github.com/Bias8145/android_kernel_google_redbull.git -b ksu-legacy-16.2 kernel/google/redbull
```

## KernelSU-Legacy Integration Guide v1.1.1
This document provides technical instructions for integrating KernelSU-Legacy v1.1.1 into the Redbull kernel source (kernel/google/redbull).
Version Metadata
| Metric | Value |
|---|---|
| KernelSU-Legacy Version | 1.1.1 |
| Target Kernel Tree | kernel/google/redbull |
| Architecture | ARM64 |

### Integration Steps:
#### 1. Set Source Root
Navigate to the root directory of your kernel source to ensure all subsequent commands are executed relative to the correct path:
```bash
cd kernel/google/redbull
```

#### 2. Automatic Patching
Execute the following command to download and run the official setup script. This process will pull the KernelSU-Legacy source into the driver tree and apply the necessary kernel hooks automatically:
```bash
curl -LSs "https://raw.githubusercontent.com/KernelSU-Legacy/KernelSU-Legacy/v1.1.1/kernel/setup.sh" | bash -
```

#### 3. Return to previous directory
```bash
cd ../../..
```
