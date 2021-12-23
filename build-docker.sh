#!/bin/bash

#Crea worspace para el curso
mkdir workspace

# Crea imagen de docker a utilizar
docker build  -t "curso-sodep" .

#Crea compose de dockers
#docker-compose up
