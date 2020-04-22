require 'minitest/autorun'
require './lib/url_validator'

class TestUrlValidator < Minitest::Test
  def test_validate
    assert_equal false, UrlValidator.new('google.com').validate
    assert_equal true,  UrlValidator.new('http://google.com').validate
  end
end
