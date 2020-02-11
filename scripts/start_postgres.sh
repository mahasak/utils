#!/usr/bin/env bash

docker run --rm   --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/volumes/postgres/latest:/var/lib/postgresql/data  postgres
