# vintagestory-server

## how to use

1. clone this repo, make three directories `mods, logs, saves` in it
2. install docker, give that user permissions to use docker
3. change the UID and GUID in [compose.yaml](./compose.yaml) to the uid and gid from `id`
4. configure [serverconfig.json](./serverconfig.json) to your liking, put the download links for any mods you want to install in [modlist](./modlist)
5. `docker compose up -d` to start it
6. access the server console with `docker compose attach vsserver` then CTRL+P -> CTRL+Q to detach