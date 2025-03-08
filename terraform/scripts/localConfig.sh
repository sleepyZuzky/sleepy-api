#!/bin/bash

local_project_rootDir_path=$1
terraform_rootDir_path=$2
cd "$local_project_rootDir_path" || exit
npm install pg
npm install -g pm2@latest
pm2 init
cp "$terraform_rootDir_path"/config/database.js "$local_project_rootDir_path"/config/database.js
cp "$terraform_rootDir_path"/config/plugins.js "$local_project_rootDir_path"/config/plugins.js
cp "$terraform_rootDir_path"/config/ecosystem.config.js "$local_project_rootDir_path"/ecosystem.config.js
