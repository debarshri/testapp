require 'logger'

class CampaignManager
  class << self
    $logger = Logger.new($stdout)
    $logger.info("Creating campaign manager..")

    def banner(campaign_id)
      campaign_id
    end


    def bestPerformingBanners(campaign_id)
      campaign_id
    end

  end
end