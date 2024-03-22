Bitbid for Docker
===================

[![Docker Stars](https://img.shields.io/docker/stars/imnotsatoshi/bitbid.svg)](https://hub.docker.com/r/imnotsatoshi/bitbid/)
[![Docker Pulls](https://img.shields.io/docker/pulls/imnotsatoshi/bitbid.svg)](https://hub.docker.com/r/imnotsatoshi/bitbid/)
[![Build Status](https://travis-ci.org/imnotsatoshi/docker-bitbid.svg?branch=master)](https://travis-ci.org/imnotsatoshi/docker-bitbid/)

Docker image that runs the Bitbi bitbid node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](http://bit.ly/1HngXg0), [Digital Ocean](http://bit.ly/18AykdD), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 500 GB to store the block chain files (and always growing!)
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on unadvertised (only shown within control panel) [Vultr SATA Storage 1024 MB RAM/250 GB disk instance @ $10/mo](http://bit.ly/vultrbitbid).  Vultr also *accepts Bitbi payments*!



Quick Start
-----------

1. Create a `bitbid-data` volume to persist the bitbid blockchain data, should exit immediately.  The `bitbid-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=bitbid-data
        docker run -v bitbid-data:/bitbi/.bitbi --name=bitbid-node -d \
            -p 9801:9801 \
            -p 127.0.0.1:9800:9800 \
            imnotsatoshi/bitbid

2. Verify that the container is running and bitbid node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        imnotsatoshi/bitbid:latest     "btb_oneshot"       2 seconds ago       Up 1 seconds        127.0.0.1:9800->9800/tcp, 0.0.0.0:9801->9801/tcp   bitbid-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f bitbid-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* Additional documentation in the [docs folder](docs).
