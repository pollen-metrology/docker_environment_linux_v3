#!/bin/bash
#getent passwd erichard

function createNewUser() {
    if id $1 > /dev/null 2>&1
    then
        echo "user exist !"
    else
        echo "user doesn't exist"
        adduser --disabled-password --gecos "" $1
        echo "$1:000000" | chpasswd    
    fi
}

createNewUser "erichard" "2223"
createNewUser "azias" "2224"
createNewUser "ethierry" "2225"
createNewUser "jytissot" "2226"
createNewUser "mviardot" "2227"

# add path arc
# home/phabricator/arcanist/bin/arc

#/bin/bash
/usr/bin/./jenkins-slave.sh
