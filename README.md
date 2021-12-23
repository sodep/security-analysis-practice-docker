# Docker para practicas de analisis de seguridad SAST PHP

##Levantar el docker:

Ejecutar los siguientes comandos:

- docker build  -t curso .
- docker-compose up

Si levanta, verificar esto : https://stackoverflow.com/questions/51445846/elasticsearch-max-virtual-memory-areas-vm-max-map-count-65530-is-too-low-inc

Este docker-compose creará un contenedor para sonar con postgres, y un SO Ubuntu con todo lo necesario para el ejercicio

##Probar los contenedores:
###Sonar
El sonar debe estar corriendo en localhost:9000, el usuario pass por defecto es : admin, admin

###Ubuntu
Se ingresa a la terminal mediante el comando:

`docker exec -it security-analysis-practice-docker_server_1 /bin/bash`

##Analisis de seguridad
El analisis con sonar y bach se realizara con los proyectos clonados,
Lo proyectos se encuentran en la carpeta `/usr/course/repositories/sonar` y `/usr/course/repositories/bach` respectivamente en el contenedor ubuntu.
Para el sonar, en lugar de utilizar http://localhost:9000, usar http://sonarqube:9000

####Con sonar realizaremos el siguiente analisis:
- Verificarcion de los errores criticos de seguridad, y los Hotspot de seguridad
- Eliminarlos como minimo 3
- Volver a correr los analisis
- Verificar que ya no existan errors criticos, ni los hotspots

####Con bach lo haremos en el contenedor ubuntu, el comando es el siguiente :
- php bach/bach composer repositories/bach/fake-vulnerabilities-php-composer/composer.json

####Con el snyk lo haremos a traves de github
- Crear un fork del repositorio: https://github.com/marcosechague/xvwa.git
- Crear una cuenta en Snyk, a traves de GitHub (Si no la tiene, crear una)
- Agrear el proyecto Github de tu for, al Snyk
- Correr el analisis
- Eliminar las vulnerabilidades criticas, al menos 3
- Volver a correr el analisis