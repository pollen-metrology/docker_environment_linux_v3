FROM pollenm/jenkins_linux_v3
LABEL MAINTAINER Pollen Metrology <admin-team@pollen-metrology.com>

RUN apt-get update && apt-get install

# Indispensable sinon l'installation demande de choisir le keyboard
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get install -y xrdp

RUN apt-get install -y openssh-server

RUN apt-get install -y firefox

RUN apt-get install -y eclipse

RUN apt-get install -y xfce4


EXPOSE 3390
