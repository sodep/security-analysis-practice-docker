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

`docker exec -it docker_server /bin/bash`

##Analisis de seguridad
Los repositorios se encuentran para ser analizados por las herramientas correspondientes, se encuentran en la raiz del proyecto con la capeta de la herramienta.

Ejemplo, en la raiz del proyecto, existe la carpeta ``sonar``, en la misma se encuentra el repositorio para ser analizado por la herramienta sonar, de la misma forma para las demas herramientas (snyk, bach)

Estos repositorios se encuentran sincronizados por un volumen docker de la siguiente manera:

 - sonar -> /usr/course/repositories/sonar 
 - snyk -> /usr/course/repositories/snyk 
 - bach -> /usr/course/repositories/bach

El analisis con  bach y sonar se realizara con los proyectos clonados,
Lo proyectos se encuentran en la carpeta `/usr/course/repositories/bach` y `/usr/course/repositories/sonar` respectivamente en el contenedor ubuntu.

####Con bach lo haremos en el contenedor ubuntu, el comando es el siguiente :
- php bach/bach composer repositories/bach/fake-vulnerabilities-php-composer/composer.json

####Con sonar realizaremos el siguiente analisis:
(Para el sonar, en lugar de utilizar http://localhost:9000, usar http://sonarqube:9000)

- Verificarcion de los errores criticos de seguridad, y los Hotspot de seguridad
- Eliminarlos como minimo 3
- Volver a correr los analisis
- Verificar que ya no existan errors criticos, ni los hotspots

####Con el snyk lo haremos a traves de github
- Crear un fork del repositorio: https://github.com/marcosechague/xvwa.git
- Crear una cuenta en Snyk, a traves de GitHub (Si no la tiene, crear una)
- Agrear el proyecto Github de tu for, al Snyk
- Correr el analisis
- Eliminar las vulnerabilidades criticas, al menos 3
- Volver a correr el analisis