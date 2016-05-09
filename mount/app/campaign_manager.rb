require './app/data_model'
require './app/logger'

class CampaignManager

  class << self

    Logger.info("Creating campaign manager..")

    def banner(campaign_id)

      banners = banners_based_on_revenue(campaign_id)

      if banners.size == 0
        "No banners found"
      else
        banners
      end
    end

    def banner_conversion_count(campaign_id)
      @banners = DataModel::Click.all(:campaign_id => campaign_id)
    end

    def banners_based_on_revenue(campaign_id)
      @banners = getBestBanners(campaign_id)
      top_banners = fill(campaign_id, @banners)
      top_banners[rand(top_banners.size-1)]
    end

    def fill(campaign_id, banners)
      banner = []

      if banners.nil?
        Logger.info("No conversions")

        banner.concat(getBannersBasedOnClicks(campaign_id, 10-banner.size))

      elsif banners.size <= 5
        Logger.info("Less than 5 conversions")

        banner.concat(banners.map { |a| a.banner_id })
        banner.concat(getBannersBasedOnClicks(campaign_id, 5-banner.size))

      else

        Logger.info("Found 10 or more conversions")

        banner.concat(banners.map { |a| a.banner_id })
      end

      banner
    end

    def getBannersBasedOnClicks(campaign_id, limit)
      campaign_clicks = DataModel::CampaignBannerClickAggregate.all(:campaign_id => campaign_id, :order => [:impression_count.desc], :limit => limit)
      banners = campaign_clicks.map { |a| a.banner_id }

      Logger.info(banners.size)

      banners
    end

    def getBestBanners(campaign_id)
      DataModel::CampaignBannerRevenue.all(:campaign_id => campaign_id, :order => [:revenue.desc], :limit => 10)
    end
  end
end