#!/bin/bash

### after install 
bash after.install.sh
sudo apt autoremove -y

### bind install
bash bind.install.sh
sudo apt autoremove -y

### NGiNX PHP MariaDB install
#bash lemper.install.sh

### mail server install
#bash postfix.install.sh