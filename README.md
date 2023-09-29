# irrd_container_oracle
IRRD (latest) running in Oracle Linux (9-slim) Docker Container

## Links:
* IRRD: https://github.com/irrdnet/irrd
* Oracle Linux Base Image: https://hub.docker.com/_/oraclelinux
* pre-built container: https://hub.docker.com/r/network2code/irrd_container_oracle

## About the container
### Daemons running in container
* postgresql-server
* redis-server
* irrd

### Network services / listening ports
* 8000 (http)
* 43 (whois)

## IRRD Setting
### Default values / Example config:
* override password: irrd
* default IRR source: MYDB
* Mirroring disabled
* RPKI disabled
* No mail support

## Howto run this container
for operational setups we recommend to mount the config file, database and log directories
### with example config (for testing only)
    docker run -d --name irrd -p 8000:8000 -p 43:43 network2code/irrd_container_oracle:latest
### with own config
    docker run -d --name irrd -p 8000:8000 -p 43:43 -v $(pwd)/irrd.yaml:/etc/irrd.yaml network2code/irrd_container_oracle:latest
### with persisted database
    docker run -d --name irrd -p 8000:8000 -p 43:43 -v $(pwd)/irrd_postgres/:/var/lib/pgsql/data/ network2code/irrd_container_oracle:latest
### with mounted logs
	docker run -d --name irrd -p 8000:8000 -p 43:43 -v $(pwd)/irrd_logs/:/var/log/ network2code/irrd_container_oracle:latest
### recommended version
	docker run -d --name irrd -p 8000:8000 -p 43:43 -v $(pwd)/irrd.yaml:/etc/irrd.yaml -v $(pwd)/irrd_logs/:/var/log/ -v $(pwd)/irrd_postgres/:/var/lib/pgsql/data/  network2code/irrd_container_oracle:latest
* see: https://irrd.readthedocs.io/en/stable/admins/configuration/#example-configuration-file
## Howto use IRRD as standalone DB with default settings
### CREATE Maintainer + Person Pair
	override:        irrd

	mntner:          MNT-YOURNAME
	descr:           Your Maintainer Description
	admin-c:         AS12345-YN
	upd-to:          email@example.com
	auth:            MD5-PW $1$DgWyzxDq$oczucgSXz.oBu0c0nU1Ow/
	mnt-by:          MNT-YOURNAME
	source:          MYDB

	person:          Your Name
	address:         Street Name 1
	address:         12345 City
	address:         GERMANY
	mnt-by:          MNT-YOURNAME
	phone:           +49691234567
	e-mail:          email@example.com
	nic-hdl:         AS12345-YN
	source:          MYDB
* maintainer password (MD5-PW): irrd
## Development
Pull requests are welcome and will be added to the credits section

## Credits
== empty so far ==

## Donate
[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/networkcoder)
