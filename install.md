# Prepare the microSD card
## Use Raspberry Pi Imager(https://www.raspberrypi.com/software/) 
```
* CHOOSE DEVICE
  Select your device 
* CHOOSE OS
  Select Raspberry Pi OS (other) 
  Select Raspberry Pi OS (Legacy, 32-bit) Lite 
* CHOOSE STORAGE 
  Select your storage device 
* NEXT 
 
* EDIT SETTINGS
* Set hostname 
* Set username and password
! DO NOT CONFIGURE wireless LAN ! see notes below
* Set locale settings
  Select Time zone 
  Select Keyboard layout 
* SERVICES 
* Enable SSH 
* Allow public-key authentication only 
  Set authorized_key for 'user'
* SAVE 
* YES
```
## Place micro SD in Raspberry Pi 
## Connect network, HDMI & power
## Connect to IP via SSH

# To install the program run
```bash
curl -sL https://raw.githubusercontent.com/dieteroo/Public/main/install.basket | bash
```

# If you want to autostart the program run
```bash
curl -sL https://raw.githubusercontent.com/dieteroo/Public/main/install.service | bash
```

# If you want to connect via a micropython device run
```bash
curl -sL https://raw.githubusercontent.com/dieteroo/Public/main/install.hostapd | bash
```
## Afterwards use the files in /pycom to configure the micropython device

# After all is set and done, protect the boot partition
```bash
curl -sL https://raw.githubusercontent.com/dieteroo/Public/main/install.boot | bash
```
