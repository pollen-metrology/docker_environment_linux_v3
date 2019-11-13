FROM pollenm/jenkins_linux_v3
LABEL MAINTAINER Pollen Metrology <admin-team@pollen-metrology.com>

RUN apt-get update && apt-get install

# Indispensable sinon l'installation demande de choisir le keyboard
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get install -y xrdp

RUN apt-get install -y openssh-server

RUN apt-get install -y firefox

#RUN apt-get install -y eclipse

RUN apt-get install -y xfce4

RUN apt-get install -y default-jre

RUN adduser --quiet --uid 2223 erichard
RUN echo "erichard:000000" | chpasswd

RUN adduser --quiet --uid 2224 azias
RUN echo "azias:000000" | chpasswd

RUN adduser --quiet --uid 2225 ethierry
RUN echo "ethierry:000000" | chpasswd

RUN apt-get install -y xfce4-terminal
RUN update-alternatives --config x-terminal-emulator

EXPOSE 3390

#ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["/usr/bin/jenkins-slave.sh"]
