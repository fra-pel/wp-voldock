#!/bin/bash
d1rs=/docker/personale/backup/name_
# Setta ora
ora=$(date '+%Y-%m-%d')
#echo $ora
# Volumi da fare backup
vol1=name__ddata
vol2=name__wdata
# Create "backups" directory if it doesn't already exist.
#mkdir -p ~/backups >/dev/null 2>&1

# Turn off docker containers. Important!
docker compose down

# Back up volumes.
docker run -v $vol1:/volume --rm --log-driver none loomchild/volume-backup backup > $d1rs/$vol1"-"$ora.tar.bz2
docker run -v $vol2:/volume --rm --log-driver none loomchild/volume-backup backup > $d1rs/$vol2"-".tar.bz2
#echo $d1rs/$vol2"-"$ora.tar.bz2
cp docker-compose.yml $d1rs
cp .env $d1rs
# Turn on containers again.
docker compose up -d

