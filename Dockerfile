# docker build -t pollenm/docker_environment_linux_v3 .
FROM pollenm/jenkins_linux_v3
LABEL MAINTAINER Pollen Metrology <admin-team@pollen-metrology.com>

RUN apt-get update && apt-get install


#RUN locale-gen en_US.UTF-8
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8

# Indispensable sinon l'installation demande de choisir le keyboard
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get install -y xrdp

RUN apt-get install -y openssh-server

RUN apt-get install -y firefox

#RUN apt-get install -y eclipse

RUN apt-get install -y xfce4

RUN apt-get install -y default-jre

#RUN adduser --quiet --uid 2223 erichard
#RUN echo "erichard:000000" | chpasswd

#RUN adduser --quiet --uid 2224 azias
#RUN echo "azias:000000" | chpasswd

#RUN adduser --quiet --uid 2225 ethierry
#RUN echo "ethierry:000000" | chpasswd

# Disable Gnome terminal
RUN apt-get remove -y gnome-terminal

# Install xfce4 terminal
RUN apt-get install -y xfce4-terminal
#RUN update-alternatives --config x-terminal-emulator

EXPOSE 3390

COPY startup-script.sh /usr/bin/startup-script.sh
RUN chmod +x /usr/bin/startup-script.sh

RUN mkdir /pollenTools
#COPY eclipse-inst-linux64.tar.gz eclipse-inst-linux64.tar.gz
#RUN cd /pollenTools
#RUN tar -C /pollenTools -xzvf /pollenTools/eclipse-inst-linux64.tar.gz

# ntp for active directory
RUN apt-get install -y ntpdate

ENV TZ="Europe/Paris"

RUN apt-get install -y nano

# Active Directory
RUN apt-get install -y samba smbclient sssd realmd dnsutils policykit-1 packagekit sssd-tools sssd libnss-sss libpam-sss adcli

# ARC Path
ENV PATH "$PATH:/home/phabricator/arcanist/bin/arc"

# GEDIT
RUN apt-get install -y gedit

ENTRYPOINT ["/usr/bin/./startup-script.sh"]

#ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ["/usr/bin/jenkins-slave.sh"]
