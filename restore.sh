#!/bin/bash
# Volumi da fare restore
vol1=name__ddata
vol2=name__wdata
# Create "backups" directory if it doesn't already exist.
#mkdir -p ~/backups >/dev/null 2>&1

# Back up volumes.
docker run -i -v $vol1:/volume --rm  loomchild/volume-backup restore < $vol1.tar.bz2
docker run -i -v $vol2:/volume --rm  loomchild/volume-backup restore < $vol2.tar.bz2

echo "Quale ip interno vuoi utilizzare: "
read nint
sed -i 's/10.10.5.1/'"$nint"'/' docker-compose.yml
#Accendere i container.

docker compose up -d --build

