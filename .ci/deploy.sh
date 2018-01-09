#!/bin/bash
# Decrypt the private key
# openssl aes-256-cbc -e -in github_deploy_key.pub -out github_deploy_key.enc -k $enc_key
openssl aes-256-cbc -K $enc_key -in .ci/github_deploy_key.enc -out ~/.ssh/id_rsa -d && \
# Set the permission of the key
chmod 600 ~/.ssh/id_rsa && \
# Start SSH agent
eval $(ssh-agent) && \
# Add the private key to the system
ssh-add ~/.ssh/id_rsa && \
# Copy SSH config
cp .ci/ssh_config ~/.ssh/config && \
# Set Git config
git config --global user.name "Cognicious Bot" && \
git config --global user.email 'info@cognicio.us' && \
# Clone the repository
git clone git@github.com:cognicious/cognicious.github.io.git .deploy_git && \
# Deploy to GitHub
npm run deploy
