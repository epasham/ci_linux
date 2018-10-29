#!/bin/bash

docker build --tag mongodb ./

docker save mongodb:latest > ./mongodb.tar
#mv ./nb-mongo.tar ../deploy/files/
