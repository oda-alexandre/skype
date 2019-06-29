# IMAGE TO USE
FROM debian:stretch-slim

# MAINTAINER
MAINTAINER https://www.oda-alexandre.com/

# VARIABLES
ENV USER skype
ENV LANG fr_FR.UTF-8

# INSTALL PACKAGES
RUN apt-get update && apt-get install --no-install-recommends -y \
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
xdg-utils && \

# CHANGE LOCALES
echo ${LANG} > /etc/locale.gen && locale-gen && \

# ADD OF REPOS AND OF THE KEY GPG
curl -sSL https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add - && \
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype.list && \

# INSTALL APP
apt-get update && apt-get install -y \
skypeforlinux && \

# CLEANING
sudo apt-get --purge autoremove -y \
curl && \
apt-get autoclean -y && \
rm /etc/apt/sources.list && \
rm -rf /var/cache/apt/archives/* && \
rm -rf /var/lib/apt/lists/*

# ADD APP
COPY ./includes/skype /usr/local/bin/

# ADD USER
RUN useradd -d /home/${USER} -m ${USER} && \
passwd -d ${USER} && \
adduser ${USER} sudo

# SELECT USER
USER ${USER}

# SELECT WORKING SPACE
WORKDIR /home/${USER}

# START THE CONTAINER
ENTRYPOINT skype \
