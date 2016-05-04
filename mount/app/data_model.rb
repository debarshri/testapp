require 'rubygems'
require 'data_mapper'
require './app/logger'

class DataModel
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/data.db")

  class Click
    include DataMapper::Resource

    property :click_id, Integer, :key => true
    property :banner_id, Integer
    property :campaign_id, Integer
  end

  class Conversion
    include DataMapper::Resource

    property :conversion_id, Integer, :key => true
    property :click_id, Integer
    property :revenue, Float
  end

  class Impression
    include DataMapper::Resource

    property :banner_id, Integer, :key => true
    property :campaign_id, Integer, :key => true
    property :campaign_count, Integer, :default => 0, :key => true

  end

  DataMapper.finalize

  Logger.info("Creating tables..")

  DataMapper.auto_migrate!
  DataMapper.auto_upgrade!

end