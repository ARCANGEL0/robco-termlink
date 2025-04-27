#!/bin/bash

sudo systemctl stop tor
wget https://github.com/JohnMcLaren/torctl-bridged/releases/download/torctl-bridged/torctl-bridged_0.5.7-1_amd64.deb
sudo apt install torctl-bridged_0.5.7-1_amd64.deb
