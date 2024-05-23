# Neurodocker

A Dockerfile that creates an image suitable for general neuroimaging studies. This image uses Ubuntu 22.04 as its base OS and manually installs FSL and ANTs from scratch. Additionally, it includes Python 3.10 along with several libraries tailored for neuroimaging work.

## Acknowledgements
This Dockerfile was written largely with the help of William T. Reynolds and Rafael Ceschin. 

## Overview

The resulting Docker image is designed for broad use across multiple projects. It provides a versatile base that can be extended with additional packages, commands, volumes, or entrypoints to suit specific project needs. You can either download the Dockerfile and amend it as necessary, or inherit from this image on Docker Hub.

### Example Dockerfile

Here is an example of a Dockerfile that inherits from the `jor115/neurodocker` image:

```Dockerfile
FROM jor115/neurodocker
RUN echo "Hello World"
```

This approach simplifies your Dockerfiles, allowing you to add only the packages that are specific to your project.

### Benefits
Simplification
By using this base image, you can greatly simplify your Docker setup. You'll only need to add project-specific packages and configurations, reducing redundancy and complexity.

### ARM Architecture Compatibility
Inheriting from this image also helps overcome Docker's limitations on ARM architecture machines. Docker has ongoing issues with building ARM-compatible images due to several libraries not providing ARM-compatible versions. Additionally, building AMD64 images on ARM machines can be problematic.

For example, building this Dockerfile on a MacBook Pro with an M1 Pro chip can take several hours, whereas it builds in minutes on a Linux machine. Therefore, if you are using a MacBook or any other machine with an ARM chip, it is recommended to download the image from Docker Hub.

## Usage
To use this image, you can pull it from Docker Hub and extend it as needed:
```
docker pull jor115/neurodocker

```

You can then create your own Dockerfile based on this image:
```
FROM jor115/neurodocker
# Add your custom packages and commands here

```

Build and run your Docker image:
```
docker build -t my-neurodocker-image .
docker run -it my-neurodocker-image
```

