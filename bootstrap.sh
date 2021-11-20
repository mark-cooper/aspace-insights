#!/bin/bash

docker stop postgres && docker rm -f postgres || true
docker run --name postgres -e POSTGRES_PASSWORD=password -d -p 5432:5432 postgres:12
sleep 1
./bin/rake db:setup
