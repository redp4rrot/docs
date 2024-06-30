#!/bin/bash
ssh-keygen -t rsa -b 4096 -C "methamfetamine2001@gmail.com"
github_username="redp4rrot"
github_token=${GITHUB_ACCESS_TOKEN}

ssh_key=$(cat ~/.ssh/id_rsa.pub)

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $github_token" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/keys \
  -d "{\"title\": \"$(hostname)\",\"key\":\"$ssh_key\"}"

ssh -T git@github.com
sudo mkdir -p /var/www/docs
cd /var/www/docs
sudo chown -R $(whoami):$(whoami) .
git clone git@github.com:redp4rrot/docs.git .
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
mkdocs serve -a localhost:4444
