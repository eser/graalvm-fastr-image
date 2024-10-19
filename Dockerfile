FROM ubuntu:latest AS base

LABEL maintainer="Eser Ozvataf <eser@acikyazilim.com>"

ENV DEBIAN_FRONTEND=noninteractive

# Runner stage
FROM base AS runner

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git curl build-essential ca-certificates libfreetype6 r-base && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p /app /opt/java /opt/maven /tmp/downloads /tmp/download-cache

RUN --mount=type=cache,target=/tmp/download-cache \
    cd /tmp/download-cache && \
    curl -L -O https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.1/graalvm-ce-java17-linux-amd64-22.3.1.tar.gz && \
    curl -L -O https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz && \
    # curl -L -O https://github.com/oracle/fastr/releases/download/vm-22.3.1/r-installable-java17-linux-amd64-22.3.1.jar && \
    cp -R /tmp/download-cache/* /tmp/downloads/

RUN tar -xzf /tmp/downloads/graalvm-ce-java17-linux-amd64-22.3.1.tar.gz -C /opt/java
RUN tar -xzf /tmp/downloads/apache-maven-3.9.9-bin.tar.gz -C /opt/maven

RUN echo "export JAVA_HOME=\"/opt/java/graalvm-ce-java17-22.3.1\"" >> ~/.bashrc && \
    echo "export MAVEN_HOME=\"/opt/maven/apache-maven-3.9.9\"" >> ~/.bashrc && \
    echo "export PATH=\"\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH\"" >> ~/.bashrc

# Create a volume for projects
VOLUME /app/projects

WORKDIR /app

RUN . ~/.bashrc && \
    gu install R

CMD ["/bin/bash"]
