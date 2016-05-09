ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'minitest/autorun'
require './app/campaign_manager'

class CampaignManagerTest < Minitest::Test
  def test_should_always_return_unique_banners

    @banners = []

    for i in  0..9
      @banners.push(CampaignManager.banners_based_on_revenue(20, @banners))
    end

    assert_equals(@banner.size , 10)
  end

end