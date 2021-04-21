#!/bin/bash

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

VER=$(get_latest_release "guillaumetournabien/kiosk_rpi")
cp ~/.node-red/flows_raspberrypi.json ~/BackupFlow
LOCATION=$(curl -s https://api.github.com/repos/guillaumetournabien/kiosk_rpi/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/guillaumetournabien/kiosk_rpi/archive/" substr($2, 2, length($2)-3) ".zip"}') \
; curl -L -o kiosk_rpi.zip $LOCATION
unzip -o kiosk_rpi.zip -d ~/Releases
cp -f ~/Releases/kiosk_rpi-$VER/flows_raspberrypi.json ~/.node-red
node-red-restart
rm -f kiosk_rpi.zip
