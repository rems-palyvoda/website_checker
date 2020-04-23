require 'minitest/autorun'
require './lib/response_handler'

class TestResponseHandler < Minitest::Test
  def test_run
    assert_instance_of Faraday::Response, ResponseHandler.new('http://google.com').run
    assert_instance_of Faraday::ConnectionFailed, ResponseHandler.new('google.com').run
  end

  describe '.to_h' do
    describe 'when valid url' do
      subject = ResponseHandler.new('valid_url')

      # stub an object that is returned by Faraday in case of valid url
      def subject.response
        Faraday::Response.new
      end

      it 'must responds hash with suitable keys' do
        _(subject.to_h).must_be_instance_of Hash
        _(subject.to_h.keys).must_equal [:url, :status, :reason_phrase]
      end
    end

    describe 'when invalid url' do
      subject = ResponseHandler.new('invalid_url')

      # stub an object that is returned by Faraday in case of invalid url
      def subject.response
        Faraday::ConnectionFailed.new('msg')
      end

      it 'must responds hash with suitable keys' do
        _(subject.to_h).must_be_instance_of Hash
        _(subject.to_h.keys).must_equal [:url, :error]
      end
    end
  end
end
