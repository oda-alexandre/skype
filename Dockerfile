FROM debian:stretch-slim

MAINTAINER https://oda-alexandre.github.io

# INSTALLATION DES PREREQUIS
RUN apt-get update && apt-get install --no-install-recommends -y \
sudo \
locales \
apt-transport-https \
ca-certificates \
curl \
gnupg

# SELECTION DE LA LANGUE FRANCAISE
ENV LANG fr_FR.UTF-8
RUN echo fr_FR.UTF-8 UTF-8 > /etc/locale.gen && locale-gen

# AJOUT DU REPOS ET DE LA CLEF GPG
RUN curl -sSL https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
RUN echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype.list

# INSTALLATION DE L'APPLICATION
RUN apt-get update && apt-get install --no-install-recommends -y \
skypeforlinux

# NETTOYAGE
RUN sudo apt-get --purge autoremove -y \
curl && \
apt-get autoclean -y && \
rm /etc/apt/sources.list && \
rm -rf /var/cache/apt/archives/* && \
rm -rf /var/lib/apt/lists/*

COPY ./includes/skype /usr/local/bin/

# AJOUT UTILISATEUR
RUN useradd -d /home/skype -m skype && \
passwd -d skype && \
adduser skype sudo

# SELECTION UTILISATEUR
USER skype

# SELECTION ESPACE DE TRAVAIL
WORKDIR /home/skype

# COMMANDE AU DEMARRAGE DU CONTENEUR
ENTRYPOINT skype
