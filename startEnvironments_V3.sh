#!/bin/bash
# test : docker run -t -d -i -p 3390:3390 -p 2223:22 --cap-add SYS_PTRACE --name "Platypus_v3_env" -v /home/docker_dev/docker_environment_linux_3/data/home:/home --cap-add SYS_RESOURCE --cap-add SYS_TIME --dns 192.168.1.160 --dns 192.168.1.3 pollenm/docker_environment_linux_v3

V3_CONTAINER_ID=`docker container list -a   | grep pollenm/docker_environment_linux_v3 | awk '{print $1}'`
V3_CONTAINER_RUNNING=`docker container list | grep pollenm/docker_environment_linux_v3 | awk '{print $1}'`


if [ "$V3_CONTAINER_ID" == "" ]; then
    echo "Creating container for Platypus v3 environment..."
    docker run  \
        -e JENKINS_URL=https://jenkins.pollen-metrology.com/ \
        -e JENKINS_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \
        -e JENKINS_AGENT_NAME=Platypus_v3 \
        -t \
        -d \
        --restart always \
        -i \
        -p 3390:3389 \
        -p 2223:22 \
        --cap-add SYS_PTRACE \
        --name "Platypus_v3_env" \
        -v /home/docker_dev/docker_environment_linux_3/data/home:/home \
        -v pollen-dev-env:/home/pollen  \
        -v jenkins_workspace:/home/jenkins/workspace3 \
        --cap-add SYS_RESOURCE \
        --cap-add SYS_TIME \
        --dns 192.168.1.160 \
        --dns 192.168.1.3 \
        pollenm/docker_environment_linux_v3

        echo -n "  Restarting SSH and XRDP services..."
        docker exec Platypus_v3_env /etc/init.d/xrdp stop
        docker exec Platypus_v3_env rm -f /var/run/xrdp/xrdp.pid
        docker exec Platypus_v3_env rm -f /var/run/xrdp/xrdp-sesman.pid
        docker exec Platypus_v3_env /etc/init.d/xrdp start
        docker exec Platypus_v3_env /etc/init.d/ssh start
        docker exec Platypus_v3_env /etc.init.d/dbus start
        echo "Done"

else
    if [ "$V3_CONTAINER_RUNNING" == "" ]; then
        echo -n "Restart existing container for Platypus v3 environment: "
        docker container start $V3_CONTAINER_ID
        echo ".. Done"

        echo -n "  Restarting SSH and XRDP services..."
        docker exec Platypus_v3_env /etc/init.d/xrdp stop
        docker exec Platypus_v3_env rm -f /var/run/xrdp/xrdp.pid
        docker exec Platypus_v3_env rm -f /var/run/xrdp/xrdp-sesman.pid
        docker exec Platypus_v3_env /etc/init.d/xrdp start
        docker exec Platypus_v3_env /etc/init.d/ssh start
        echo "Done"
    else
        echo "Platypus v3 environment is already running"
    fi
fi
