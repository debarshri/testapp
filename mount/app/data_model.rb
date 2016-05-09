require 'rubygems'
require 'data_mapper'
require './app/logger'

class DataModel
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/data.db")

  class Click
    include DataMapper::Resource

    property :click_id, Integer, :key => true
    property :banner_id, Integer
    property :campaign_id, Integer, :index => true

  end

  class Conversion
    include DataMapper::Resource

    property :click_id, Integer, :key => true
    property :conversion_id, Integer
    property :revenue, Float, :default => 0.0
  end

  class CampaignBannerRevenue
    include DataMapper::Resource

    property :campaign_id, Integer, :key => true
    property :banner_id, Integer, :key => true
    property :revenue, Float, :default => 0.0

  end

  class CampaignBannerClickAggregate
    include DataMapper::Resource

    property :campaign_id, Integer, :key => true
    property :banner_id, Integer, :key => true
    property :click_count, Integer, :default => 0

  end

  DataMapper.finalize

  def ini
    Logger.info("Creating tables..")

    DataMapper.auto_migrate!
    DataMapper.auto_upgrade!
  end

end