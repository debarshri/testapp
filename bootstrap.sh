#!/usr/bin/env bash
cd /home/vagrant

## Required for native extensions in sqlite3

sudo apt-get -y update
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
cd /tmp
wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz
tar -xvzf ruby-2.0.0-p481.tar.gz
cd ruby-2.0.0-p481/
./configure --prefix=/usr/local
make
sudo make install

ruby --version

## Database
sudo apt-get install sqlite3
sudo apt-get install libsqlite3-dev

## Disable firewall for portforwarding
sudo ufw disable

## Gems

alias app='cd /vagrant_data/; ruby app.rb'
alias app_server='cd /vagrant_data/; ruby app.rb server_only'
alias app_db='cd /vagrant_data/; ruby app.rb initial_run'
alias tests='cd /vagrant_data/; ruby spec/campaign_spec.rb'