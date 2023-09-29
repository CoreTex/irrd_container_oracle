#!/bin/bash
VERSION=$(date +%s)
docker build --tag network2code/irrd_container_oracle:$VERSION . 
docker stop irrd 
docker rm irrd 
docker run -d --name irrd -p 8000:8000 -p 43:43 network2code/irrd_container_oracle:$VERSION
