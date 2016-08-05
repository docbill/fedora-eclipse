# fedora-eclipse
A docker container to eclipse in ubuntu with the specified workspace.

## Overview

Although there are many eclipse images available, most are very vague about
what the contain.  This container is designed primarily to run the 
Force.com IDE, but is appropriate for many other uses.  Your workspace should
be provided as a volume.  To keep things simple the eclipse will run as the
owner of that volume, and the workspace will also be used as the home directory.
That way there is no need to persist data inside the container.

 
## Quick Start

 
If you have already have docker working you can start eclipse as easily as:

	[ -d ~/workspace ] || mkdir ~/workspace
	xhost local:root
	docker run -i --net=host --rm -e DISPLAY -v $HOME/workspace/:/workspace/:z docbill/fedora-eclipse


## Windows Start

For windows this was a bit more complicated.  I had to make sure Xwin (from
cygwin) was started with the -listen tcp option, and that security was 
disabled.  Once that was done the following command worked:

	docker run -i --rm -e DISPLAY=172.31.253.119:0 -v /d/cygwin64/home/docbi/workspace/:/workspace/:z docbill/fedora-eclipse

Where my ip address is 172.31.253.119, and the folder I wanted the workspace in
was D:\cygwin64\home\docbi\workspace\

## Running With Limited Access To Your Linux Desktop

If you want to do something more advance such as granting eclipse access to
the firefox browser on your desktop you'll need to do something more
complicated such as:

	xhost local:root
	[ -n "$WORKSPACE" ] || WORKSPACE="$HOME/workspace"
	[ -d "$WORKSPACE/.eclipse" ] || mkdir -p "$WORKSPACE/.eclipse"
	docker run -i --net=host --rm --name docker-force -e DISPLAY -v /var/lib/sss:/var/lib/sss:ro -v "$HOME:$HOME" -v "$WORKSPACE/.eclipse:$HOME/.eclipse" -v /tmp:/tmp:z -v "$WORKSPACE:/workspace/:z" docbill/fedora-eclipse "$@"


## First Time Notes

The first time you run this command it will download the image.

If you wish to install the Force.com IDE, follow the instructions at:

	Force.com IDE Installation - developer.force.com
	https://developer.salesforce.com/page/Force.com_IDE

If you do not have docker installed read on.

 
## Installing Docker On Fedora, CentOS and RHEL

 

To install docker on Fedora and RHEL7, the following commands should work:

 

	sudo dnf install docker
	sudo systemctl start docker
	sudo systemctl enable docker

For older version of Fedora and RHEL6 the commands are:

	sudo yum install docker-io
	sudo service docker start
	sudo chkconfig docker on


One of the things you might want to do is to set storage options to something
other than loopback, as I find disk full errors can corrupt all your docker
images when using loopback.

