ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'minitest/autorun'
require './app/campaign_manager'

class CampaignManagerTest < Minitest::Test
  def test_should_give_banner_back
    assert [311,332,475,352,451,462,170,324,462,266].include? CampaignManager.banners_based_on_revenue(20)
  end

  def test_no_results_back
    assert CampaignManager.banners_based_on_revenue(2000).nil?
  end

end