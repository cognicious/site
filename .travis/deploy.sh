#!/bin/bash
# Decrypt the private key
# See https://github.com/alrra/travis-scripts/blob/master/doc/github-deploy-keys.md
openssl aes-256-cbc -K $encrypted_502c4417840e_key -iv $encrypted_502c4417840e_iv -in github_deploy_key.enc -out github_deploy_key -d && \
# Set the permission of the key
chmod 600 ~/.ssh/id_rsa && \
# Start SSH agent
eval $(ssh-agent) && \
# Add the private key to the system
ssh-add ~/.ssh/id_rsa && \
# Copy SSH config
cp .travis/ssh_config ~/.ssh/config && \
# Set Git config
git config --global user.name "Cognicious Bot" && \
git config --global user.email 'info@cognicio.us' && \
# Clone the repository
git clone git@github.com:cognicious/cognicious.github.io.git .deploy_git && \
# Deploy to GitHub
npm run deploy
