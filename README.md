# GraalVM FastR Docker Image

This project provides a Docker codebase with GraalVM and FastR (R language implementation) installed, allowing you to run R programs in a containerized environment.

## Project Overview

> **Warning**
> Since FastR is not available on macOS and any platform with the newest GraalVM versions, this project provides a Docker image with an older version of GraalVM that has FastR installed. See the [GraalVM R Runtime chapter in the GraalVM reference manual](https://www.graalvm.org/latest/reference-manual/r/) for more information.

The main purpose of this project is to create a reproducible and isolated environment for running R programs using GraalVM's FastR implementation. The Docker image is based on Ubuntu and includes:

- GraalVM Community Edition (Java 17)
- FastR (R language implementation for GraalVM)
- Essential build tools and dependencies

## Getting Started

### Prerequisites

- Docker Desktop (https://www.docker.com/products/docker-desktop/)

### Container Control Commands

1. Clone this repository:
   ```
   git clone https://github.com/your-username/graalvm-fastr-image.git
   cd graalvm-fastr-image
   ```

1. Build and start the container:
   ```
   make start
   ```

1. To run an interactive shell in the container:
   ```
   make run
   ```

1. To stop the container:
   ```
   make stop
   ```

1. To restart the container:
   ```
   make restart
   ```

1. To remove the container and its volumes:
   ```
   make clean
   ```

## Usage

Once you're inside the container, you can run R programs using the `R` command. The `/app/projects` directory is mounted as a volume, allowing you to share files between your host machine and the container.

### Example: Running a Spring Boot Project

To run an existing Spring Boot project within the container, follow these steps:

1. Copy your Spring Boot project to the `projects` directory on your host machine. This directory is mounted as a volume in the container.

1. Start the container if it's not already running:
   ```
   make start
   ```

1. Enter the container's shell:
   ```
   make run
   ```

1. Once inside the container, navigate to your project directory:
   ```
   cd /app/projects/your-spring-boot-project
   ```

1. Build and run your Spring Boot application using Maven:
   ```
   mvn spring-boot:run
   ```

Note: Make sure your Spring Boot project's `pom.xml` file is compatible with the Java version installed in the container (Java 17). You may need to adjust your project's Java version if it's different.
