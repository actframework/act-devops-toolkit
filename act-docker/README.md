# Act.Framework Docker Deploy Tool

This is the toolkit for using Act.Framework in Docker and Cloud Foundry environments

## Overview

This little tool is designed to make it easy to install Act.Framework applications as services in local and remote Docker containers. 

The idea behind using this tool is that you would _install_ the docker deploy capability into an existing Act.Framework project structure. So, if you have an existing project located in `~/Development/hello-world` then you would run the `install.sh` command as follows:

```
install.sh -p=~/Development/hello-world 

```

Once you have installed the Docker deployment toolkit into your project, you can adapt the Dockerfile or docker-compose.yml files by going into the `docker` directory.

To deploy the application into Docker, simply use the `docker-deploy.sh` command. Note that the deploy will run Gulp and Maven targets and package them before attempting to deploy. 



## Usage

```
install.sh -p=~/Development/hello-world 

```

## Command Line Parameters

`-p` or `--path` is used to tell the Docker Deploy installer where the Act.Framework application exists on the local filesystem.
```
-p=<path to project on local filesystem>

```




# Using the `docker-deply.sh` command

This will setup a Docker container for you and embed the application as a service inside that container so that you can 'up' services or restart them and the service will start as part of the linux startup sequence if you restart a container.

##Switches for Docker Deploy

`--clean` to force all containers to recreate and redelpoy

`--noup` to build the docker container only without deployment

`--nobuild` to deploy the current docker container only

`-?` or `--help`


