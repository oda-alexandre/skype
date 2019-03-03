# SKYPE

[![dockeri.co](https://dockeri.co/image/alexandreoda/skype)](https://hub.docker.com/r/alexandreoda/skype)


## INDEX

- [Badges](#BADGES)
- [Introduction](#INTRODUCTION)
- [Prerequis](#PREREQUIS)
- [Installation](#INSTALLATION)
- [License](#LICENSE)


## BADGES

[![version](https://images.microbadger.com/badges/version/alexandreoda/skype.svg)](https://microbadger.com/images/alexandreoda/skype)
[![size](https://images.microbadger.com/badges/image/alexandreoda/skype.svg)](https://microbadger.com/images/alexandreoda/skype")
[![build](https://img.shields.io/docker/build/alexandreoda/skype.svg)](https://hub.docker.com/r/alexandreoda/skype)
[![automated](https://img.shields.io/docker/automated/alexandreoda/skype.svg)](https://hub.docker.com/r/alexandreoda/skype)


## INTRODUCTION

Ce repository contient le fichier Dockerfile de [skype](https://www.skype.com/fr/) pour [docker](https://www.docker.com), mis à jour automatiquement dans le [docker hub](https://hub.docker.com/r/alexandreoda/skype) public.


## PREREQUIS

Installer [docker](https://www.docker.com)


## INSTALLATION

```
docker run -d --name skype -v ${HOME}:/home/skype -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /dev/snd:/dev/snd -v /dev/shm:/dev/shm -v /var/run/dbus:/var/run/dbus -v /etc/localtime:/etc/localtime:ro -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native --group-add $(getent group audio | cut -d: -f3) -e DISPLAY alexandreoda/skype
```


## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://github.com/oda-alexandre/skype/blob/master/LICENSE)
