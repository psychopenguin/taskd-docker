#!/bin/sh

echo "USING $TASKDDATA as datadir"

if [ ! -f $TASKDDATA/config ] ; then
    echo "Config does not exists... creating"
    taskd init
    taskd config server 0.0.0.0:53589
    echo "setting up ssl"
    for FILE in $(ls /ssl/*pem); do
        taskd config --force $(basename $FILE .pem) $FILE
    done
    echo "Config done. starting up"
else
    echo "Config file already exists... proceeding to startup"
fi

taskd server
