# noda2xsoar
Script that converts Noda.io 3D mental models to  Cortex XSOAR Playbook mock up

## Quick Start

Download the script

Plug your oculus quest usb into your computer

Unlock and "allow access to your data" from inside vr

copy ```/Android/Data/com.codingleap.noda/files/Maps/YOURFILE.json``` to same directory as the downloaded script

run script against the json file
```sh
./noda2xsoar.sh YOURFILE.json
```

upload output.yml to xsoar

in xsoar all the section headers will be stacked, simply edit the playbook and press "Auto Align"
