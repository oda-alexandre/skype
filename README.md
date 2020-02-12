# SKYPE

<img src="https://assets.gitlab-static.net/uploads/-/system/project/avatar/12904476/0f6568_b9f9ef83261142a6be7e5b5d8caabc90.jpg" width="200" height="200"/>

## INDEX

- [SKYPE](#skype)
  - [INDEX](#index)
  - [BADGES](#badges)
  - [INTRODUCTION](#introduction)
  - [PREREQUISITES](#prerequisites)
  - [INSTALL](#install)
  - [LICENSE](#license)

## BADGES

[![pipeline status](https://gitlab.com/oda-alexandre/skype/badges/master/pipeline.svg)](https://gitlab.com/oda-alexandre/skype/commits/master)

## INTRODUCTION

Docker image of :

- [skype](https://www.skype.com/fr/)

Continuous integration on :

- [gitlab](https://gitlab.com/oda-alexandre/skype/pipelines)

Automatically updated on :

-[docker hub public](https://hub.docker.com/r/alexandreoda/skype)

## PREREQUISITES

Use [docker](https://www.docker.com)

## INSTALL

```docker run -d --name skype -v ${HOME}:/home/skype -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /dev/snd:/dev/snd -v /dev/shm:/dev/shm -v /var/run/dbus:/var/run/dbus -v /etc/localtime:/etc/localtime:ro -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native --group-add $(getent group audio | cut -d: -f3) -e DISPLAY alexandreoda/skype```

## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://gitlab.com/oda-alexandre/skype/blob/master/LICENSE)
