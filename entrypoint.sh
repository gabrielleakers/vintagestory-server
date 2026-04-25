#!/bin/bash

while read p; do
    echo "Downloading mod: $p"
    [ ! -e "/home/vintagstory/data/Mods/$(basename $p)" ] && wget "$p" -p /home/vintagstory/data/Mods
done <modlist

/home/vintagstory/server/server.sh start