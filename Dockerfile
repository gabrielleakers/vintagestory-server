FROM ubuntu:24.04

ARG UID
ARG GUID

USER root

RUN apt-get update && \
    apt-get install -y wget screen procps

RUN wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb

RUN apt-get update && \
    apt-get install -y dotnet-runtime-10.0

RUN groupadd -g ${GUID} -o vintagestory
RUN useradd -m -u ${UID} -g ${GUID} -o -s /bin/bash vintagestory

RUN mkdir -p /home/vintagestory/data/Mods && \
    mkdir -p /home/vintagestory/data/Logs && \
    mkdir -p /home/vintagestory/data/Saves && \
    chown -hR vintagestory:vintagestory /home/vintagestory/data

COPY --chown=vintagestory serverconfig.json /home/vintagestory/data/serverconfig.json
COPY --chown=vintagestory entrypoint.sh /home/vintagestory/entrypoint.sh
COPY --chown=vintagestory modlist /home/vintagestory/modlist

RUN chmod +x /home/vintagestory/entrypoint.sh

USER vintagestory

WORKDIR /home/vintagestory

RUN wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_1.22.0.tar.gz -O vs_server_linux.tar.gz && \
    mkdir server && \
    tar -C server -xzf vs_server_linux.tar.gz && \
    rm vs_server_linux.tar.gz && \
    chmod +x server/server.sh

ENTRYPOINT ["./entrypoint.sh"]