ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'minitest/autorun'
require 'httpclient'
require './app/server'
class CampaignManagerTest < Minitest::Test

  $clnt = HTTPClient.new
  $base_url = "http://0.0.0.0:3000"

  def test_if_server_works
    assert_equal 'Hello, World!', get('/')
  end

  def test_if_campaign_works
    assert_equal '<h1>10000</h1>', get('/campaign/10000')
  end

  def get(url)
    $clnt.get_content($base_url+url)
  end

end