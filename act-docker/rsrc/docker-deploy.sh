#!/bin/bash
echo 
echo "---------------------------------"
echo "Act.Framework Docker Deploy Tool "
echo "---------------------------------"
echo ""
echo "(C)2017 Thinking.Studio "
echo "Written by J.Cincotta"
echo ""
echo "Use -? for help"
echo ""

for i in "$@"
do
case $i in
    --clean)
    CLEAN=YES
    shift # past argument with no value
    ;;
    --noup)
    NOUP=YES
    shift # past argument with no value
    ;;
    --nobuild)
    NOBUILD=YES
    shift # past argument with no value
    ;;
  
    -?|--help)
        echo ""
        echo "--clean to force all containers to recreate"
        echo ""
        echo "--noup to build the docker container only"
        echo ""
        echo "--nobuild to deploy the docker container only"
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

#obtain the base directory to get the resources (even if we have been called from an alias)
BASEDIR=`eval echo "$(dirname "$(readlink "$0")")"`
if [[ "${BASEDIR}" == '.' ]]; then
    BASEDIR="$(cd "$(dirname "$0")" && pwd)"
fi

RSRCDIR=`eval echo "${BASEDIR}/docker"`
mkdir ${RSRCDIR}

#package and unzip the distribution
cd ${BASEDIR}
rm -rf target/dist/*
mvn clean package
cd target/dist
unzip *.zip
rm *.zip 

#put the docker stuff in that taregt/dist directory
cp ${RSRCDIR}/Dockerfile ${BASEDIR}/target/dist/Dockerfile
cp ${RSRCDIR}/docker-compose.yml ${BASEDIR}/target/dist/docker-compose.yml
cp ${RSRCDIR}/service.sh ${BASEDIR}/target/dist/service.sh
cp ${RSRCDIR}/service-runner.sh ${BASEDIR}/target/dist/service-runner.sh
cp ${RSRCDIR}/service-installer.sh ${BASEDIR}/target/dist/service-installer.sh

#docker that shizzle
echo "Composing and starting container..."
cd ${BASEDIR}/target/dist/
if [[ "${NOUP}" == 'YES' ]]; 
    then
        docker-compose build
        exit
fi
if [[ "${NOBUILD}" == 'YES' ]]; 
    then
        docker-compose up -d --no-build
        exit
fi
if [[ "${CLEAN}" == 'YES' ]]; 
    then
        docker-compose up -d --build --force-recreate
        exit
fi
docker-compose up -d --build


