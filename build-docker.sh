#!/bin/bash

#Crea worspace para el curso
mkdir workspace

# Crea imagen de docker a utilizar
docker build  -t "curso" .

#Crea compose de dockers
docker-compose up
