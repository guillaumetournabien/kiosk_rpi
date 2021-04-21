#!/bin/bash

mkdir -p ~/BackupFlow
cp ~/.node-red/flows_raspberrypi.json ~/BackupFlow
rm -f ~/.node-red/flows_raspberrypi.json
node-red-restart