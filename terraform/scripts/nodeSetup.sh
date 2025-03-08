#!/bin/bash

echo '>> CONFIGURING NODE SETUP .....'
cd ~ || exit
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
. ~/.nvm/nvm.sh
sudo apt-get update
nvm install 22
npm install -g pnpm@latest-10
npm install -g pm2
echo '<<   NODE SETUP DONE   >>'
