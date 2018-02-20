# Equipos de fútbol - Persistencia en MongoDB

[![Build Status](https://travis-ci.org/uqbar-project/eg-equipos-futbol-mongodb.svg?branch=master)](https://travis-ci.org/uqbar-project/eg-equipos-futbol-mongodb) [![Coverage Status](https://coveralls.io/repos/github/uqbar-project/eg-equipos-futbol-mongodb/badge.svg?branch=master&service=github)](https://coveralls.io/github/uqbar-project/eg-equipos-futbol-mongodb?branch=master&service=github)


## Objetivo
Testea el mapeo de una [aplicación de planteles de equipos de fútbol](https://github.com/uqbar-project/eg-equipos-futbol-mongodb/wiki) con MongoDB. 

## Modelo
La base de datos se estructura en un documento jerárquico:

* equipo 
 * jugadores

## Instalación
Antes de correr los test, tenés que instalar una base de datos [MongoDB Community Edition](https://www.mongodb.com/) y levantar el server. En Windows, [levantan el servicio mongod](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/), en Linux desde una línea de comandos hacen

```bash
$ sudo service mongod start
```

En la carpeta [scripts](scripts) vas a encontrar dos archivos:

* [Script Jugadores](scripts/Script_Jugadores.txt) para ejecutarlo en el shell de MongoDB (ejecutable mongo). Este script inserta datos de varios equipos de fútbol con sus jugadores.
* [Queries Jugadores](scripts/Queries_Jugadores.txt) con queries de ejemplo para probar directamente en el shell.

Acá te mostramos cómo correr los scripts con [Robomongo](https://robomongo.org/) un cliente MongoDB con algunas prestaciones gráficas:

![video](video/demo.gif)

**Los scripts deberías ejecutarlos en la base de datos "test"**. Si elegís otra base tenés que modificar el string de conexión en la clase Xtend _RepoJugadoresMongoDB_.

Luego sí, podés correr los tests del proyecto Xtend, que verifica

* que Palermo no está en el plantel de Boca del juego de datos
* que Riquelme sí está en el plantel de Boca del juego de datos
* que hay dos jugadores que comienzan con "Casta" (Castagno de Tigre y Dino Castaño de Boca)

## Proyecto
El proyecto base de Xtend está usando directamente el [driver para Java que provee MongoDB](https://docs.mongodb.com/getting-started/java/client/).

