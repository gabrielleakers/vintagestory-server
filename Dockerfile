FROM ubuntu:24.04

USER root

RUN apt-get update && \
    apt-get install -y wget

RUN wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb

RUN apt-get update && \
    apt-get install -y dotnet-runtime-10.0

RUN useradd --create-home --shell /bin/bash vintagestory

USER vintagestory

WORKDIR /home/vintagestory

RUN wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_1.22.0.tar.gz -O vs_server_linux.tar.gz && \
    mkdir server && \
    tar -C server -xzf vs_server_linux.tar.gz && \
    rm vs_server_linux.tar.gz && \
    chmod +x server/server.sh

RUN mkdir -p data/

COPY serverconfig.json data/serverconfig.json

COPY entrypoint.sh entrypoint.sh
COPY modlist modlist

ENTRYPOINT ["entrypoint.sh"]