# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #                                                                                     # #
# #    Use Raspberry Pi Imager  (https://www.raspberrypi.com/software/)                 # #
# #    * CHOOSE DEVICE                                                                  # #
# #      Select your device                                                             # #
# #    * CHOOSE OS                                                                      # #
# #      Select Raspberry Pi OS (other)                                                 # #
# #      Select Raspberry Pi OS (Legacy, 32-bit) Lite                                   # #
# #    * CHOOSE STORAGE                                                                 # #
# #      Select your storage device                                                     # #
# #    * NEXT                                                                           # #
# #                                                                                     # #
# #    * EDIT SETTINGS                                                                  # #
# #    * Set hostname                                                                   # #
# #    * Set username and password                                                      # #
# #    ! DO NOT CONFIGURE wireless LAN !   see notes below                              # #
# #    * Set locale settings                                                            # #
# #    Select Time zone                                                                 # #
# #    Select Keyboard layout                                                           # #
# #    * SERVICES                                                                       # #
# #    * Enable SSH                                                                     # #
# #    * Allow public-key authentication only                                           # #
# #    Set authorized_key for 'user'                                                    # #
# #    * SAVE                                                                           # #
# #    * YES                                                                            # #
# #                                                                                     # #
# #    Place micro SD in Raspberry Pi                                                   # #
# #    Connect network, HDMI & power                                                    # #
# #    Connect to IP via SSH                                                            # #
# #                                                                                     # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #                                                                                     # #
# #    NOTES                                                                            # #
# #    ---                                                                              # #
# #    If you want to change the image location change image/_LOGO_.png                 # #
# #    basketclockthread.py                                                             # #
# #    line 25                                                                          # #
# #    LogoClub = pygame.image.load('image/_LOGO_.png')                                 # #
# #    ---                                                                              # #
# #    Make sure the IPv4 address is the same in both files listed below                # #
# #    basketclockthread.py                                                             # #
# #    line 255                                                                         # #
# #       serv.bind(('10.3.141.1', 8080))                                               # #
# #    pycom/main.py                                                                    # #
# #    line 28                                                                          # #
# #       client.connect(('10.3.141.1', 8080))                                          # #
# #    ---                                                                              # #
# #    _wifi_SSID_ and _wifi_PASSWORD_ are created in the RASPAP setup below            # #
# #    Make sure the _wifi_SSID_ is unique for its location                             # #
# #    pycom/boot.py                                                                    # #
# #    line 20                                                                          # #
# #       wlan.connect('_wifi_SSID_', auth=(WLAN.WPA2, '_wifi_PASS_'), timeout=5000)    # #
# #    ---                                                                              # #
# #    Connect to wifi-network raspi-webgui                                             # #
# #    See https://docs.raspap.com/ap-basics/                                           # #
# #    Change the SSID, and secret.  Also update the admin password.                    # #
# #    ---                                                                              # #
# #    Make sure to run this command via SSH after the script has run                   # #
# #    sudo mount -o remount,ro /boot                                                   # #
# #    sudo raspi-config nonint enable_bootro                                           # #
# #                                                                                     # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
