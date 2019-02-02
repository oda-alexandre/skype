FROM debian:stretch-slim

MAINTAINER https://oda-alexandre.github.io

# INSTALLATION DES PREREQUIS
RUN apt-get update && apt-get install --no-install-recommends -y \
sudo \
locales \
ca-certificates \
apt-transport-https \
gnupg \
dirmngr \
wget

# SELECTION DE LA LANGUE FRANCAISE
ENV LANG fr_FR.UTF-8
RUN echo fr_FR.UTF-8 UTF-8 > /etc/locale.gen && locale-gen

# AJOUT DU REPOS ET DE LA CLEF GPG
RUN echo 'deb [arch=amd64] https://repo.skype.com/deb stable main' >> /etc/apt/sources.list.d/skype-stable.list && \
set -ex; \
export GNUPGHOME="$(mktemp -d)"; \
for key in D4040146BE3972509FD57FC71F3045A5DF7587C3; do \
gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
done; \
gpg --batch --export $GPG_KEYS > /etc/apt/trusted.gpg.d/skype.gpg; \
rm -rf "$GNUPGHOME"; \
apt-key list; \
apt-mark auto '.*' > /dev/null; \
[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark

# INSTALLATION DE L'APPLICATION
RUN apt-get update && apt-get install -y \
skypeforlinux

# AJOUT INCLUDES
COPY ./includes/skype.sh  /usr/local/bin/skype.sh
RUN chmod +x /usr/local/bin/skype.sh

# NETTOYAGE
RUN apt-get --purge autoremove -y \
wget && \
apt-get autoclean -y && \
rm /etc/apt/sources.list && \
rm -rf /var/cache/apt/archives/* && \
rm -rf /var/lib/apt/lists/*

# AJOUT UTILISATEUR
RUN useradd -d /home/skype -m skype && \
passwd -d skype && \
adduser skype sudo

# SELECTION UTILISATEUR
USER skype

# SELECTION ESPACE DE TRAVAIL
WORKDIR /home/skype

# COMMANDE AU DEMARRAGE DU CONTENEUR
CMD skype
