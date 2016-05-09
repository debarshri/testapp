require './app/data_model'
require './app/logger'

class CampaignManager

  class << self

    Logger.info("Creating campaign manager..")

    def banner(campaign_id, banners_served)

      if banners_served.nil?
        banners_based_on_revenue(campaign_id, [])
      else
        banners_based_on_revenue(campaign_id, banners_served)
      end
    end

    def banners_based_on_revenue(campaign_id, banners_served)
      @banners = getBestBanners(campaign_id,banners_served)
      top_banners = fill(campaign_id, @banners, banners_served)
      top_banners[rand(top_banners.size-1)]
    end

    def fill(campaign_id, banners,banners_served)
      banner = []

      if banners.nil?
        Logger.info("No conversions")

        banner.concat(getBannersBasedOnClicks(campaign_id, 10-banner.size,banners_served))

      elsif banners.size <= 5
        Logger.info("Less than 5 conversions")

        banner.concat(banners) # Add all the banners with conversions
        banner.concat(getBannersBasedOnClicks(campaign_id, 5-banner.size, banners_served)) # Rest of the top5 thing, fill based on clicks

      else

        Logger.info("Found 10 or more conversions")
        banner.concat(banners.map { |a| a.banner_id })
      end

      banner
    end

    def getBannersBasedOnClicks(campaign_id,limit, banners_served)

      Logger.info(banners_served)

      @campaign_clicks = DataModel::CampaignBannerClickAggregate.all(:campaign_id => campaign_id,
                                                                    :order => [:click_count.desc])
      @campaign_clicks = @campaign_clicks.select { |banner| !banners_served.include?(String(banner.banner_id)) }
      @campaign_clicks.map { |a| a.banner_id }

      if @campaign_clicks.size > limit
        @banners.slice(0, limit)
      else
        @banners
      end

    end

    def getBestBanners(campaign_id,banners_served)

      @banners =  DataModel::CampaignBannerRevenue.all(:campaign_id => campaign_id,
                                           :order => [:revenue.desc])
      @banners = @banners.select { |banner| !banners_served.include?(String(banner.banner_id)) }

      if @banners.size > 10
        @banners.slice(0, 10)
      else
        @banners
      end
    end
  end
end