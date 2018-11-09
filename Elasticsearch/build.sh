#!/bin/bash

docker build --tag elasticsearch ./

docker save elasticsearch:latest > ./elasticsearch.tar


