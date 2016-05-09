require 'rubygems'
require 'sinatra'
require 'erubis'
require 'securerandom'
require './app/campaign_manager'
require './app/logger'
require 'json'

class App < Sinatra::Base

  enable :sessions

  configure do
    set :port, 3000
    set :bind, '0.0.0.0'
  end

  get '/' do
    "It works"
  end

  def set_banner(banner_id, banners_served)
    banner_ids = JSON.parse banners_served
    JSON.generate (banner_ids.push(banner_id))
  end

  get '/campaign/:campaign_id' do
    uid = request.cookies['uid']
    total_banners_served = request.cookies['total_banners_served']
    banners_served = request.cookies['banners_served']

    if uid.nil?
      response.set_cookie('uid', :value => SecureRandom.uuid, :expires => Time.now + 86400000)
    end

    if total_banners_served.nil?
      response.set_cookie('total_banners_served', :value => 1, :expires => Time.now + 86400000)
    else
      total_banners_served = Integer(total_banners_served) + 1
      response.set_cookie('total_banners_served', :value => total_banners_served, :expires => Time.now + 86400000)
    end

    banner_id = CampaignManager.banner(params['campaign_id'], banners_served)

    Logger.info("UUID is #{uid}, total banners served #{total_banners_served},
                    banners served #{banners_served}, banner id now is #{banner_id}")

    if banner_id.nil?
      erb "<h1>Banner not found</h1>"
    else

      if banners_served.nil?
        value = set_banner(banner_id, [])
        response.set_cookie('banners_served', :value => value, :expires => Time.now + 86400000)
      else
        value = set_banner(banner_id, banners_served)
        response.set_cookie('banners_served', :value => value, :expires => Time.now + 86400000)
      end

      erb "<h1><%= banner_id %></h1>", :locals => {:banner_id => banner_id}
    end
  end

end