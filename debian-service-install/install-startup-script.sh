#!/bin/bash

for i in "$@"
do
case $i in
    -s=*|--servicename=*)
    SERVICENAME="${i#*=}"
    shift # past argument=value
    ;;
    -p=*|--path=*)
    SERVICEPATH="${i#*=}"
    shift # past argument=value
    ;;
    -i|--install)
    INSTALL=YES
    shift # past argument with no value
    ;;
    -r|--remove)
    REMOVE=YES
    shift # past argument with no value
    ;;
    -q|--query)
    QUERY=YES
    shift # past argument with no value
    ;;
    -?|--help)
        echo "Act.Framework Debian Service Installer"
        echo ""
        echo "-p or --path to specify the path to the root of the Act.Framework project"
        echo "example -p=/home/helloworld"
        echo ""
        echo "-s or --servicename to specify the name of the service to be installed"
        echo "example -s=myservice"
        echo ""
        echo "-r or --remove to remove a service from the system"
        echo ""
        echo "-i or --install to install the service into the system"
        echo ""
        echo "-q or --query to show if the service is already installed"
        echo ""
        echo ""
        echo "-? or --help ... well, you know what that command does now. You're reading it."
        exit
    shift # past argument=value
    ;;
    *)
            # unknown option
    ;;
esac
done

if [[ "${INSTALL}" == 'YES' ]];
    then
        echo "Installing service ${SERVICENAME}..."
        sudo adduser ${SERVICENAME}
        sudo chown -R ${SERVICENAME}:${SERVICENAME} ${SERVICEPATH}
        sudo sed "s|SERVICENAME|${SERVICENAME}|" startup-script.sh >temp_${SERVICENAME}
        sudo sed "s|SERVICEPATH|${SERVICEPATH}|" temp_${SERVICENAME} >/etc/init.d/${SERVICENAME}
        sudo chmod u+x /etc/init.d/${SERVICENAME}
        sudo update-rc.d ${SERVICENAME} 
            #statements
fi

if [[ "${REMOVE}" == 'YES' ]];
    then
        echo "Removing service ${SERVICENAME}..."
        sudo service ${SERVICENAME} stop
        sudo update-rc.d -f ${SERVICENAME} remove
fi

if [[ "${QUERY}" == 'YES' ]];
    then
        echo "Querying ${SERVICENAME}..."
        sudo chkconfig ${SERVICENAME} on
fi
