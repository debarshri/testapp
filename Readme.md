## Possible commands

`vagrant up`

or

`vagrant up --provision`

Vagrant up is slow when executed first, because it build ruby 2.0.0 from scratch.

Also, there would be errors and warnings. You can ignore it.

`vagrant ssh`

for running test

`cd /vagrant_data/; rake test`

for running server

`cd /vagrant_data/; rake server`

check for example

`http://192.168.50.4:3000`
or
`http://192.168.50.4:3000/campaign/2`

for clean install

`cd /vagrant_data/; rake app`
