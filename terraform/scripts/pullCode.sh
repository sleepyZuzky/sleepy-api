#!/bin/bash

echo '>> PULLING STRAPI APP SOURCE CODE .....'
export GIT_USERNAME=$1
export GIT_PASSWORD=$2
your_username=$3
your_repo=$4
# git clone https://$GIT_USERNAME:$GIT_PASSWORD@github.com/your_username/your_repo.git
git clone https://"$GIT_USERNAME":"$GIT_PASSWORD"@github.com/"$your_username"/"$your_repo".git sleepy-api
echo '<<   STRAPI APP SOURCE CODE PULLED  >>'
cd ~ || exit
