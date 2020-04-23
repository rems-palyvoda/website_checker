require 'minitest/autorun'
require './lib/url_validator'

class TestUrlValidator < Minitest::Test
  def test_valid?
    assert_equal false, App::UrlValidator.new('google.com').valid?
    assert_equal true,  App::UrlValidator.new('http://google.com').valid?
  end

  def test_has_scheme?
    assert_equal false, App::UrlValidator.new('google.com').valid?
    assert_equal true,  App::UrlValidator.new('abcd://google.com').valid?
    assert_equal true,  App::UrlValidator.new('http://google.com').valid?
  end

  def test_prepare
    assert_equal 'http://google.com',  App::UrlValidator.new('google.com').prepare
    assert_equal 'http://google.com',  App::UrlValidator.new('http://google.com').prepare
  end
end
