#!/bin/bash
VERSION=$(date +%s)
docker build --tag network2code/irrd_container_oracle:$VERSION . 
docker push network2code/irrd_container_oracle:$VERSION
