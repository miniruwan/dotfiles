#!/bin/bash

sudo cp /mnt/c/ProgramData/netskope/stagent/data/nscacert.pem /mnt/c/ProgramData/netskope/stagent/data/nstenantcert.pem /usr/local/share/ca-certificates/
sudo mv nscacert.pem nscacert.crt
sudo mv nstenantcert.pem nstenantcert.crt
sudo update-ca-certificates