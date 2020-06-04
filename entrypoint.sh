#!/bin/bash

SSH_PRIVATE_KEY=$1
DOKKU_APP_NAME=$2
DOKKU_HOST=$3
DOKKU_PORT=$4
DOKKU_USER=$5
GIT_BRANCH=$6
GIT_FLAGS=$7

# Setup the SSH environment
mkdir -p ~/.ssh
eval `ssh-agent -s`
ssh-add - <<< $SSH_PRIVATE_KEY
ssh-keyscan $DOKKU_HOST >> ~/.ssh/known_hosts
chown 400 ~/.ssh/id_rsa

# Setup the git environment
REMOTE=$DOKKU_USER@$DOKKU_HOST:$DOKKU_APP_NAME
cd $GITHUB_WORKSPACE
git remote add deploy $REMOTE

# Prepare to push to Dokku git repository
REMOTE_REF=$GITHUB_SHA:refs/heads/$GIT_BRANCH
GIT_COMMAND="git push deploy $REMOTE_REF $GIT_FLAGS"
echo "GIT_COMMAND=$GIT_COMMAND"

# Push to Dokku git repository
GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p ${DOKKU_PORT} $GIT_COMMAND
