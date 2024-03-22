bitbid config tuning
======================

You can use environment variables to customize config ([see docker run environment options](https://docs.docker.com/engine/reference/run/#/env-environment-variables)):

        docker run -v bitbid-data:/bitbi/.bitbi --name=bitbid-node -d \
            -p 9801:9801 \
            -p 127.0.0.1:9800:9800 \
            -e REGTEST=0 \
            -e DISABLEWALLET=1 \
            -e PRINTTOCONSOLE=1 \
            -e RPCUSER=mysecretrpcuser \
            -e RPCPASSWORD=mysecretrpcpassword \
            imnotsatoshi/bitbid

Or you can use your very own config file like that:

        docker run -v bitbid-data:/bitbi/.bitbi --name=bitbid-node -d \
            -p 9801:9801 \
            -p 127.0.0.1:9800:9800 \
            -v /etc/mybitbi.conf:/bitbi/.bitbi/bitbi.conf \
            imnotsatoshi/bitbid
