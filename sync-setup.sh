#!/bin/bash

cd /var/opt/gitlab/git-data/repositories/deepak/
echo "Input the repository name, in the format <repo.git> followed by [ENTER]:"
read REPONAME

if [ -d "$REPONAME" ]; then
  echo "Repository Exists!";
  cd $REPONAME;
  if [ ! -d "custom_hooks" ]; then
    mkdir custom_hooks/
    echo "exec git push --quiet github &" > custom_hooks/post-receive
    chown -R git:git custom_hooks
    chmod +x custom_hooks/post-receive
    echo "Successfully created a post-receive hook."
  else
    echo "custom_hooks directory already exists. Exiting..."
    exit 1
  fi

  echo "Configuring the repository..."
  echo '[remote "github"]' >> config
  echo "url = git@github.com:deepaknadig/$REPONAME" >> config
  echo "fetch = +refs/*:refs/*" >> config
  echo "mirror = true" >> config
  echo "Configuration complete."
  echo "Your repository should sync now on new commits."
else
  echo "Repository does not exist! Create it first and then rerun the script";
  echo "Exiting..."
fi
