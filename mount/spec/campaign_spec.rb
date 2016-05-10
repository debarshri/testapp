ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'minitest/autorun'
require './app/campaign_manager'

class CampaignManagerTest < Minitest::Unit::TestCase

  def setup
    @banners = []

    (0..9).each do
      banner = CampaignManager.banners_based_on_revenue(20, @banners)
      @banners = @banners.push(banner)
    end
  end

  def test_should_always_return_unique_banners
    assert_equal(@banners.size, 10)
  end

  def test_should_banners_in_revenue_order

    @campaign1 = CampaignManager.findBestBanners(20,[])
    @campaign2 = CampaignManager.findBestBanners(20,@campaign1)

    assert(@campaign1[0].revenue >= @campaign2[0].revenue)
  end

end