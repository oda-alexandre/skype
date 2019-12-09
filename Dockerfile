FROM debian:stretch-slim

LABEL authors https://www.oda-alexandre.com/

ENV USER skype
ENV LOCALES fr_FR.UTF-8

RUN echo -e '\033[36;1m ******* INSTALL PACKAGES ******** \033[0m'; \
apt update && apt install --no-install-recommends -y \
sudo \
locales \
apt-transport-https \
ca-certificates \
curl \
gnupg \
dirmngr \
alsa-utils \
libasound2 \
libasound2-plugins \
pulseaudio \
pulseaudio-utils \
libcanberra-gtk-module \
libcanberra-gtk3-module \
libgl1-mesa-dri \
libgl1-mesa-glx \
mesa-utils \
xdg-utils

RUN echo -e '\033[36;1m ******* CHANGE LOCALES ******** \033[0m'; \
locale-gen ${LOCALES}

RUN echo -e '\033[36;1m ******* ADD SOURCE APP & KEY GPG ******** \033[0m'; \
curl -sSL https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -; \
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype.list

RUN echo -e '\033[36;1m ******* INSTALL APP ******** \033[0m'; \
apt update && apt install -y \
skypeforlinux

RUN echo -e '\033[36;1m ******* CLEANING ******** \033[0m'; \
sudo apt-get --purge autoremove -y \
curl; \
apt-get autoclean -y; \
rm /etc/apt/sources.list; \
rm -rf /var/cache/apt/archives/*; \
rm -rf /var/lib/apt/lists/*

RUN echo -e '\033[36;1m ******* ADD APP ******** \033[0m'
COPY ./includes/skype /usr/local/bin/

RUN echo -e '\033[36;1m ******* ADD USER ******** \033[0m'; \
useradd -d /home/${USER} -m ${USER}; \
passwd -d ${USER}; \
adduser ${USER} sudo

RUN echo -e '\033[36;1m ******* SELECT USER ******** \033[0m'
USER ${USER}

RUN echo -e '\033[36;1m ******* SELECT WORKING SPACE ******** \033[0m'
WORKDIR /home/${USER}

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'
ENTRYPOINT skype \