# SKYPE

![logo](https://assets.gitlab-static.net/uploads/-/system/project/avatar/12904476/0f6568_b9f9ef83261142a6be7e5b5d8caabc90.jpg)

- [SKYPE](#skype)
  - [INDEX](#index)
  - [BADGES](#badges)
  - [INTRODUCTION](#introduction)
  - [PREREQUISITES](#prerequisites)
  - [INSTALL](#install)
    - [DOCKER RUN](#docker-run)
    - [DOCKER COMPOSE](#docker-compose)
  - [LICENSE](#license)

## BADGES

[![pipeline status](https://gitlab.com/oda-alexandre/skype/badges/master/pipeline.svg)](https://gitlab.com/oda-alexandre/skype/commits/master)

## INTRODUCTION

Docker image of :

- [skype](https://www.skype.com/fr/)

Continuous integration on :

- [gitlab pipelines](https://gitlab.com/oda-alexandre/skype/pipelines)

Automatically updated on :

-[docker hub public](https://hub.docker.com/r/alexandreoda/skype)

## PREREQUISITES

Use [docker](https://www.docker.com)

## BUILD

### DOCKER RUN

```\
docker run -d \
--name skype \
--group-add audio \
--device /dev/snd \
-e DISPLAY \
-e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
-v ${HOME}:/home/skype \
-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
-v /dev/shm:/dev/shm \
-v /var/run/dbus:/var/run/dbus \
-v /etc/localtime:/etc/localtime:ro \
-v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
alexandreoda/skype
```

### DOCKER COMPOSE

```yml
version: "2.0"

services:
  skype:
    container_name: skype
    image: alexandreoda/skype
    restart: "no"
    privileged: false
    devices:
      - /dev/snd
    volumes:
      - "${HOME}:/home/skype"
      - "/tmp/.X11-unix/:/tmp/.X11-unix/"
      - "/dev/shm:/dev/shm"
      - "/var/run/dbus:/var/run/dbus"
      - "/etc/localtime:/etc/localtime:ro"
      - "/tmp/.X11-unix/:/tmp/.X11-unix/"
```

## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://gitlab.com/oda-alexandre/skype/blob/master/LICENSE)
