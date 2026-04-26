#!/bin/bash

while read p; do
    filename=$(basename $p)
    echo "Downloading mod: /home/vintagestory/data/Mods/$filename"
    wget -vnc "$p" -O /home/vintagestory/data/Mods/$filename
done <modlist

/home/vintagestory/server/server.sh start