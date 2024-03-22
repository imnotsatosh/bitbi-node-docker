# Debugging

## Things to Check

* RAM utilization -- bitbid is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The bitbi blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 40GB+ is necessary.

## Viewing bitbid Logs

    docker logs bitbid-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the bitbid node, but will not connect to already running containers or processes.

    docker run -v bitbid-data:/bitbi --rm -it imnotsatoshi/bitbid bash -l

You can also attach bash into running container to debug running bitbid

    docker exec -it bitbid-node bash -l


