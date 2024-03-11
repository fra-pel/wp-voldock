#!/bin/bash
#nome=`sed -n -e '/COMPOSE_PROJECT_NAME/ s/.*\= *//p' .env`
#!/bin/bash
declare -i por2=0
declare -i por3=0
dirs=/docker/personale/wp-volsite
mkdir $dirs
iploc=10.10.5.1
echo "Inserisci nome progetto: "
read nome
echo "WORDPRESS - Inserisci porta: "
read por1
echo "WORDPRESS - Inserisci indirizzo ip: "
read indir1
echo "MARIADB - Inserisci indirizzo ip: "
read indir2
echo "PHPMYADMIN - Inserisci indirizzo ip: "
read indir3
por2=$por1+2
#por3=$por1+2
echo ""
echo "################[ DATI ]###################"
echo ""
echo "Nome progetto: $nome"
echo "Indirizzo IP WORDPRESS: $indir1 PORTA: $por1"
# echo "Indirizzo IP MARIADB: $indir2"
echo "Indirizzo IP PHPMYADMIN: $indir3 PORTA: $por2"
echo ""
pr="${nome:0:3}"
ran=$RANDOM
mkdir $dirs/$nome
#mkdir $dirs/$nome/wordpress
#mkdir $dirs/$nome/mysql
mkdir $dirs/$nome/config
cp config/php.conf.ini $dirs/$nome/config
cp docker-compose.yml $dirs/$nome/
cp .env $dirs/$nome/
cd $dirs/$nome
sed -i 's/iploc/'"$iploc"'/' docker-compose.yml
sed -i 's/db_/'"$nome"_db'/' docker-compose.yml
sed -i 's/dv_/'wdata'/' docker-compose.yml
sed -i 's/dbv_/'ddata'/' docker-compose.yml
sed -i 's/zx_/'"$nome"_db'/' .env
sed -i 's/db__/'"$nome"'/' .env
sed -i 's/pr_/'"$pr"_'/' .env
sed -i 's/ran_/'"$nome"_"$ran"'/' .env
sed -i 's/wp__/'"$nome"_wp'/' docker-compose.yml
sed -i 's/indir1/'"$indir1"'/' docker-compose.yml
sed -i 's/indir2/'"$indir2"'/' docker-compose.yml
sed -i 's/indir3/'"$indir3"'/' docker-compose.yml
sed -i 's/por1/'"$por1"'/' docker-compose.yml
sed -i 's/por2/'"$por2"'/' docker-compose.yml
echo "OK TERMINATO"
echo "############[ AVVIO ]##############"
docker pull wordpress:latest
docker pull mariadb:latest
docker pull phpmyadmin/phpmyadmin:latest
docker-compose up -d --build
