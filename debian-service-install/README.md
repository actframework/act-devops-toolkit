# Debian Service Installer for Act.Framework

## Overview

This little tool is designed to make it easy to install Act.Framework
applications as services on Debian based linux servers. 

This is useful because we need to have the ability to start the web application when the server
reboots without manually starting Act.Framework from the command line...

Using this tool you should be able to have a regular Act.Framework application
run in production mode unattended as long as it has already been compiled. This is
expecially important with Node.JS applications that you are using the Target
ZIP after you have run Gulp AND run Maven compile.

To build, compile and package for upload to a production server, type the
following commands into the command line from the top-level directory of the
project:

```
gulp
mvn compile
mvn package

``` 

Once you do this, you will find a ZIP file for download which should have
everything you need all packaged up in it for you. It is available from:

```
~/my-application-name/target/dist/

```
That is, from the directory in which you project is contained, you can go down
to the *target/dist* directory and find a ZIP file with your web application
packed ready to go.


## Usage

```
sudo install-startup-script.sh -p=/home/act/hello-world -s=myservicename -i 

```

## Command Line Parameters

`-p` or `--path` is used to tell the service installer where the Act.Framework
application exists on the local filesystem.
```
-p=<path to code on local debian filesystem>

```

`-s` or `--servicename` is used to define the name of the Debian service being
installed on the system (or removed from the system)
```
-s=<name of the service>

```

`-i` or `--install` is a switch to tell the installer to install a service

`-r` or `--remove` is a switch to tell the installer to remove a service

`-q` or `--query` is a switch to tell the installer to simply query to see if the
service is actually installed


