ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'minitest/autorun'
require './app/campaign_manager'

class CampaignManagerTest < Minitest::Test
  def test_should_always_return_unique_banners
    @banners = []

    (0..9).each do
      banner = CampaignManager.banners_based_on_revenue(20, @banners)
      @banners = @banners.push(banner)
    end

    assert_equal(@banners.size, 10)
  end

end