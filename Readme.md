## Possible commands

`vagrant up`

or

`vagrant up --provision`

Vagrant up is slow when executed first, because it build ruby 2.0.0 from scratch.

Also, there would be errors and warnings. You can ignore it.

`vagrant ssh`

`cd /vagrant_data/; rake test`

`cd /vagrant_data/; rake server`


for running test
`rake test`

for running server
`rake server`

for clean install
`rake app`