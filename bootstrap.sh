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
gem install sinatra --no-rdoc
gem install shotgun
gem install sqlite3
gem install logger
gem install erubis
gem install rspec
gem install rack
gem install test
gem install unit
gem install rack-test
gem install minitest
gem install httpclient
gem install rake
gem install binstall undler
gem install data_mapper
gem install rubygems
gem install dm-sqlite-adapter
gem install bundler

alias tests='cd /vagrant_data/; rake test'
alias start_app='cd /vagrant_data/; rake server'