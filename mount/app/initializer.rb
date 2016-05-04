require 'sqlite3'
require 'csv'
require './app/server'
require './app/data_model'
require './app/logger'

class Initializer

  class << self

    def run()
      App.run!
    end

    def insert_impression_data
      Logger.info("processing impressions..(this is going to take a while)")

      @impressions = File.read("data/impressions.csv")
      CSV.parse(@impressions).each_with_index do |row, i|
        next if i == 0
        impression = DataModel::Impression.first_or_create banner_id: Integer(row[0]),
                                                           campaign_id: Integer(row[1])
        impression.campaign_count =+1
        impression.save
        if i%5000 == 0
          Logger.info("Row count '#{i}'")
        end
      end

      Logger.info("Total impressions..#{DataModel::Impression.all.size}")
    end

    def insert_conversion_data
      Logger.info("processing conversions")

      CSV.parse(File.read("data/conversions.csv")).each_with_index do |row, i|

        next if i == 0
        DataModel::Conversion.create conversion_id: Integer(row[0]),
                                     click_id: Integer(row[1]),
                                     revenue: Float(row[2])
        if i%1000 == 0
          Logger.info("Row count '#{i}'")
        end
      end

      Logger.info("Total conversions..#{DataModel::Conversion.all.size}")
    end

    def insert_click_data
      Logger.info("processing clicks")
      CSV.parse(File.read('data/clicks.csv')).each_with_index do |row, i|
        next if i == 0
        DataModel::Click.create click_id: Integer(row[0]),
                                banner_id: Integer(row[1]),
                                campaign_id: Integer(row[2])
        if i%1000 == 0
          Logger.info("Row count '#{i}'")
        end
      end

      Logger.info("Total clicks..#{DataModel::Click.all.size}")
    end

  end
end