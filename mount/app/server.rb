require 'rubygems'
require 'sinatra'
require 'erubis'
require './app/campaign_manager'

class App < Sinatra::Base

  configure do
    set :port, 3000
    set :bind, '0.0.0.0'
  end

  get '/' do
    "Hello, World!"
  end

  get '/campaign/:campaign_id' do
    erb "<h1><%= CampaignManager.banner(#{params['campaign_id']}) %></h1>"
  end

end