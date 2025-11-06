#!/bin/bash

PROVISIONING="/etc/firstboot/container_provisioning/provisioning.bin"
DOWNLOAD_PROVISIONING="/etc/firstboot/provisioning/donwload_provisioning.bin"
VOLUME="/etc/guarddog"
device_name=$1
license_email=$2
license_key=$3
env=$4
DEBUG=True
EXTERNAL_LOG=$6
version=$7
DEBUG_DEFAULT="True"


print_provisioning_values() {
    echo "---------------------------------------------"
    echo " DEVICE NAME:"$device_name
    echo " EMAIL:"$license_email
    echo " LICENSE KEY:"$license_key
    echo " ENV:"$env
    echo "---------------------------------------------"

}

create_volume_folders() {
    echo "---------------------------------------------"
    echo " Creating volume directories."
    echo "---------------------------------------------"
    echo $VOLUME/
    echo $VOLUME/opt  
    echo $VOLUME/logs 
    echo $VOLUME/keys 
    echo $VOLUME/config_files 
    echo $VOLUME/scripts  
    echo $VOLUME/licenses
    mkdir -p $VOLUME/
    mkdir -p $VOLUME/opt  
    mkdir -p $VOLUME/logs 
    mkdir -p $VOLUME/keys 
    mkdir -p $VOLUME/config_files 
    mkdir -p $VOLUME/scripts  
    mkdir -p $VOLUME/licenses
    
}

set_image_version() {
    echo "---------------------------------------------"
    echo " Saving edge sensor image version: $SENSOR_VERSION"
    echo "---------------------------------------------"
}


set_environment() {
    echo "---------------------------------------------"
    echo " Saving environment: $env"
    echo "---------------------------------------------"
    echo $env > /etc/guarddog/opt/env
}

set_system_Log() {    
    echo "---------------------------------------------"
    echo " Saving system log: $EXTERNAL_LOG"
    echo "---------------------------------------------"
    echo $EXTERNAL_LOG > /etc/guarddog/opt/external_log
}


update_provisioning_repo(){
    echo "---------------------------------------------"
    echo " Downloading Provisioning binaries.."
    echo "---------------------------------------------"
    sudo git pull
}

set_supervisord(){
    echo "---------------------------------------------"
    echo " Running supervisord ..."
    echo "---------------------------------------------"
    sudo mkdir -p /var/run && \
    sudo chown root:root /var/run && \
    sudo chmod 755 /var/run
    sudo supervisord -c /etc/supervisord.conf > /dev/null 2>&1 &
}

set_system_Log() {
    if [[ $DEBUG == $DEBUG_DEFAULT ]]; then
        echo "---------------------------------------------"
        echo " Saving system log: $EXTERNAL_LOG"
        echo "---------------------------------------------"
    fi
        echo $EXTERNAL_LOG > /etc/guarddog/opt/external_log
}

################################
print_provisioning_values

if [ -z "$license_key" ]; then
        echo "No License"
    else
    create_volume_folders
    update_provisioning_repo
    set_image_version
    set_environment
    set_system_Log
    set_supervisord
fi


echo "----------------------------------------"
echo "--------------- Testing ----------------"
echo "----------------------------------------"



