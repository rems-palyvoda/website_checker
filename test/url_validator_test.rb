require 'minitest/autorun'
require './lib/url_validator'

class TestUrlValidator < Minitest::Test
  def test_valid?
    assert_equal false, App::UrlValidator.new('abs://google.com').valid?
    assert_equal true,  App::UrlValidator.new('http://google.com').valid?
  end

  def test_has_scheme?
    assert_equal false,  App::UrlValidator.new('google.com').send(:has_scheme?)
    assert_equal true,  App::UrlValidator.new('http://google.com').send(:has_scheme?)
  end

  def test_add_scheme
    App.set_preferences({scheme: 'test://'})
    subject = App::UrlValidator.new('google.com')
    subject.valid?
    assert_equal 'test://google.com', subject.url
    App.set_preferences({})
  end
end
