#!/bin/bash

## Enable Boot Read-Only
sudo raspi-config nonint enable_bootro

## Reboot
echo -n "The system needs to be rebooted as a final step. Reboot now? [Y/n]: "
            read answer < /dev/tty
            if [ "$answer" != "${answer#[Nn]}" ]; then
                echo "Installation reboot aborted."
                exit 0
            fi
            sudo shutdown -r now
