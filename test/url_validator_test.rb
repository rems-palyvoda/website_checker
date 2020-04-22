require 'minitest/autorun'
require './lib/url_validator'

class TestUrlValidator < Minitest::Test
  def test_valid?
    assert_equal false, UrlValidator.new('google.com').valid?
    assert_equal true,  UrlValidator.new('http://google.com').valid?
  end
end
