#!/usr/bin/env bash

echo '---------- Starting provisioning'

# update linux environment
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install git-all -y
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev flex gettext libgmp3-dev -y

sudo apt-get autoremove -y

# Configure git
echo '---------- Configure git'
echo $1
echo $2

git config --global color.ui true

# Following stage required to be configured by individuals
git config --global user.name $1
git config --global user.email $2
ssh-keygen -t rsa -C $2

#https://gorails.com/setup/ubuntu/14.04
cd ~

if [ ! -d ".rbenv" ]; then
  echo '---------- Install ruby: clone rbevn'
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv

  echo '---------- Install ruby: clone ruby-build'
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

  echo '---------- Install ruby: clone rbevn-gem-rehash'
  git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

  echo '---------- Install ruby: Setup environment'
  echo 'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc

  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
  eval "$(rbenv init -)"

  echo '---------- Install ruby: install'
  rbenv install 2.2.3
  rbenv global 2.2.3
fi

echo '---------- Install bundler'
gem install bundler
rbenv rehash

# install rails
echo '---------- Install Rails'
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"
rbenv global 2.2.3
gem install rails -v 4.2.4
rbenv rehash

# setup git prompt
cd ~
if [ ! -d ".bash-git-prompt" ]; then
  echo '---------- Setup git prompt'

  git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
  echo 'source ~/.bash-git-prompt/gitprompt.sh' >> ~/.bashrc
  echo 'GIT_PROMPT_ONLY_IN_REPO=1' >> ~/.bashrc
fi

# switch to Snoop3 folder and clone the repo
cd /srv
if [ ! -d "supermoo" ]; then
  echo '---------- Clone repo'
  git clone https://github.com/Fjool/SuperMOO-Reboot.git supermoo
fi

cd supermoo

echo '---------- Bundle install'
bundle install
