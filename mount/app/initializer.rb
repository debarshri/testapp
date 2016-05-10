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

    def insert_conversion_data
      Logger.info('processing conversions (this is going to take a while)')

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
      Logger.info('processing clicks (this is going to take a while)')

      CSV.parse(File.read('data/clicks.csv')).each_with_index do |row, i|
        next if i == 0
        DataModel::Click.create click_id: Integer(row[0]),
                                banner_id: Integer(row[1]),
                                campaign_id: Integer(row[2])

        create_banners_per_campaign(row)

        if i%1000 == 0
          Logger.info("Rows processed '#{i}'")
        end
      end

      Logger.info("Total clicks..#{DataModel::Click.all.size}")
    end

    def revenue_per_campaing_banner
      Logger.info("processing revenue per campaing, banner_id (this is going to take a while)")

      @conversions = DataModel::Conversion.all()

      for conversion in @conversions
        click = DataModel::Click.get(conversion.click_id)

        unless click.nil?
          campaign_banner_revenue = DataModel::CampaignBannerRevenue.first_or_create banner_id: click.banner_id,
                                                                                     campaign_id: click.campaign_id
          campaign_banner_revenue.revenue += conversion.revenue
          campaign_banner_revenue.save
        end
      end
      Logger.info("Total Campaign Banner Revenue..#{DataModel::CampaignBannerRevenue.all.size}")
    end

    def create_banners_per_campaign(row)
      banners_per_campaign = DataModel::CampaignBannerClickAggregate.first_or_create campaign_id: Integer(row[2]),
                                                                                     banner_id: Integer(row[1])
      banners_per_campaign.click_count += 1
      banners_per_campaign.save
    end

  end
end