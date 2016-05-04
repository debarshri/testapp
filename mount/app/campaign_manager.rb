require 'logger'
require './app/data_model'

class CampaignManager

  class << self

    $logger = Logger.new($stdout)
    $logger.info("Creating campaign manager..")

    def banner(campaign_id)
      impression = Database::Impression.get(:campaign_id == campaign_id);
      impression.banner_id
    end

  end
end