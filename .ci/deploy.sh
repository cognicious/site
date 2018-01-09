#!/bin/bash
# Decrypt the private key
# openssl aes-256-cbc -e -in github_deploy_key.pub -out github_deploy_key.enc -K $enc_key -iv $enc_iv
openssl aes-256-cbc -in .ci/github_deploy_key.enc -out github_deploy_key.pub -K $enc_key -iv $enc_iv -d && \
# Set Git config
git config core.sshCommand 'ssh -i $PWD/github_deploy_key.pub'
git config --global user.name "Cognicious Bot" && \
git config --global user.email 'info@cognicio.us' && \
# Clone the repository
git clone git@github.com:cognicious/cognicious.github.io.git .deploy_git && \
# Deploy to GitHub
npm run deploy
