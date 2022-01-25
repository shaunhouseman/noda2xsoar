# noda2xsoar
Script that converts Noda.io 3D mental models to  Cortex XSOAR Playbook mock up

<img src="https://user-images.githubusercontent.com/39415579/151071854-ed8c40ed-958f-497b-87fd-d5f5fd76ffba.png" width=40% height=40%> <img src="https://user-images.githubusercontent.com/39415579/151072027-66765ccb-7b21-44e5-8f6e-1590ed3e2122.png" width=50% height=50%>


## Quick Start

1. Download the script

2. Plug your oculus quest usb into your computer

3. Unlock and "allow access to your data" from inside vr

4. copy ```/Android/Data/com.codingleap.noda/files/Maps/YOURFILE.json``` to same directory as the downloaded script

5. run script against the json file
```sh
./noda2xsoar.sh YOURFILE.json
```

6. upload output.yml to xsoar

7. in xsoar all the section headers will be stacked, simply edit the playbook and press "Auto Align" <img src="https://user-images.githubusercontent.com/39415579/151072170-7dfcc684-7d76-405d-9aa1-7a5aa845aada.png" width=3% height=3%>
