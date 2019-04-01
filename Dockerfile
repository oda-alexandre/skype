FROM debian:stretch-slim

MAINTAINER http://www.oda-alexandre.com/

# VARIABLES
ENV USER skype
ENV LANG fr_FR.UTF-8

# INSTALLATION DES PREREQUIS
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

# SELECTION DE LA LANGUE FRANCAISE
echo ${LANG} > /etc/locale.gen && locale-gen && \

# AJOUT DU REPOS ET DE LA CLEF GPG
curl -sSL https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add - && \
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype.list && \

# INSTALLATION DE L'APPLICATION
apt-get update && apt-get install -y \
skypeforlinux && \

# NETTOYAGE
sudo apt-get --purge autoremove -y \
curl && \
apt-get autoclean -y && \
rm /etc/apt/sources.list && \
rm -rf /var/cache/apt/archives/* && \
rm -rf /var/lib/apt/lists/*

COPY ./includes/skype /usr/local/bin/

# AJOUT UTILISATEUR
RUN useradd -d /home/${USER} -m ${USER} && \
passwd -d ${USER} && \
adduser ${USER} sudo

# SELECTION UTILISATEUR
USER ${USER}

# SELECTION ESPACE DE TRAVAIL
WORKDIR /home/${USER}

# COMMANDE AU DEMARRAGE DU CONTENEUR
ENTRYPOINT skype
