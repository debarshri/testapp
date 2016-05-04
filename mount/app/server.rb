require 'rubygems'
require 'sinatra'
require 'erubis'
require './app/campaign_manager'

class App < Sinatra::Base

  configure do
    set :port, 4567
  end

  get '/' do
    "<h2>Hello, World!</h2>"
  end

  get '/campaign/:campaign_id' do
    erb "<h1><%= CampaignManager.banner(#{params['campaign_id']}) %></h1>"
  end

end