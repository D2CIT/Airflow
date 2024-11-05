#!/bin/bash
###################################
# Setup containers
###################################

# Start podman if not active
if ! podman machine ls | grep -q 'Running'; then
    echo "Podman machine is not running. Starting..."
    podman machine start
else
    echo "Podman machine is already running or in the process of starting."
fi

# build and start
podman-compose up -d --build

# Start
# podman-compose up

# open airflow webpage
open http://localhost:8080

# list all containers
podman ps --all

# get current airflow.cfg file
podman exec -it local_airflow-webserver_1 cat /opt/airflow/airflow.cfg > ~/Documents/airflow/local/config/airflow.cfg
podman exec -it local_airflow-webserver_1 cat /opt/airflow/webserver_config.py > ~/Documents/airflow/local/config/webserver_config.py
# get current log file
podman logs local_airflow-webserver_1  > ~/Documents/airflow/local/log/airflow_after_setup.log

# connect to commandline of the container
podman exec -it local_airflow-webserver_1 /bin/bash
podman exec -it local_airflow-webserver_1 /bin/sh

###################################
# Curl
###################################

# read roles
curl -X GET "http://localhost:8080/api/v1/roles" \
    -H "Content-Type: application/json" \
    -u admin:admin

# get current log file
podman logs local_airflow-webserver_1   > ~/Documents/airflow/local/log/airflow_after_read.log

# Write roles
curl -X POST "http://localhost:8080/api/v1/roles" \
    -H "Content-Type: application/json" \
    -u admin:admin \
    -d '{"name": "admin_config"}'

# get current log file
podman logs local_airflow-webserver_1  > ~/Documents/airflow/local/log/airflow_after_create.log

###################################
# Python
###################################

# Run python to read role
python3  ~/Documents/airflow/local/scripts/read_role.py
# get current log file
podman logs local_airflow-webserver_1  > ~/Documents/airflow/local/log/airflow_after_python_read.log

# Run python to create role
python3  ~/Documents/airflow/local/scripts/create_role.py

# get current log file
podman logs local_airflow-webserver_1  > ~/Documents/airflow/local/log/airflow_after_python_create.log

###################################
# clean up podman containers
###################################

# List Containers
podman ps -a ;

# Stop and delete all containers
podman rm -a -f ;

# delete all images
podman rmi -a -f ;

# Prune volumes and networks (optioneel)
podman volume prune -f ;
podman network prune -f