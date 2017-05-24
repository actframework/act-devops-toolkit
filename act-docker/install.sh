#!/bin/bash
echo
echo "-------------------------------------------"
echo "Act.Framework Docker Deploy Tool Installer"
echo "-------------------------------------------"
echo ""
echo "(C)2017 Thinking.Studio "
echo "Written by J.Cincotta"
echo ""
echo "Use -? for help"
echo ""
for i in "$@"
do
case $i in
    -p=*|--path=*)
    PROJECTPATH="${i#*=}"
    shift # past argument=value
    ;;
    -f|--force)
    FORCE="1"
    shift # past argument=value
    ;;
  
    -?|--help)
		echo ""
		echo "This installer will make a Docker deployment script and supporting files for Act.Framework applications to use Docker and install the files into the specified Act.Framework application directory."
		echo ""
        echo "-p or --path to specify the path to the root of the Act.Framework project"
        echo "example -p=~/Development/helloworld"
        echo ""
        echo "-f or --force to force overwrite of Docker files"
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


if [[ ${PROJECTPATH} == '' ]]; then
	echo -n "Enter the Act.Framework application path to install Docker Deploy tools: "
	read PROJECTPATH
	echo 
fi

#Fix project path (expand ~ if there is one... and deal with relative path)
tempProjectPath=${PROJECTPATH}
if [[ ${tempProjectPath:0:1} == "~" ]] || [[ ${tempProjectPath:0:1} == "/" ]]; then 
    PROJECTPATH=`eval echo "${tempProjectPath}"`
else
    PROJECTPATH="$(pwd)"/"${PROJECTPATH}"
fi

if [ ! -d "${PROJECTPATH}" ] ; then
	echo "Path ${PROJECTPATH} does not exist, cannot continue."
fi

#obtain the base directory to get the resources (even if we have been called from an alias)
BASEDIR=`eval echo "$(dirname "$(readlink "$0")")"`
if [[ "${BASEDIR}" == '.' ]]; then
    BASEDIR="$(cd "$(dirname "$0")" && pwd)"
fi
RSRCDIR=`eval echo "${BASEDIR}/rsrc"`

#Fix project path (expand ~ if there is one... and deal with relative path)
tempProjectPath=${PROJECTPATH}
if [[ ${tempProjectPath:0:1} == "~" ]] || [[ ${tempProjectPath:0:1} == "/" ]]; then 
    PROJECTPATH=`eval echo "${tempProjectPath}"`
else
    PROJECTPATH="$(pwd)"/"${PROJECTPATH}"
fi

TARGETPATH=${PROJECTPATH}/docker

#put resource files in the docker dir as long as it has not been created before
if [ ! -d ${TARGETPATH} ] || [ ${FORCE} == "1" ]; then
    mkdir ${TARGETPATH}
    cp ${RSRCDIR}/docker-compose.yml ${TARGETPATH}
    cp ${RSRCDIR}/Dockerfile ${TARGETPATH}
    cp ${RSRCDIR}/service-installer.sh ${TARGETPATH}
    cp ${RSRCDIR}/service-runner.sh ${TARGETPATH}
    cp ${RSRCDIR}/service.sh ${TARGETPATH}

    #put docker deploy script in root of project
    cp ${RSRCDIR}/docker-deploy.sh ${PROJECTPATH}
else
    echo "Docker directory already exists. Aborting..."
    echo
fi
echo "Done."


