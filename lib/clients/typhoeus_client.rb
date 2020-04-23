require 'typhoeus'

module App
  class TyphoeusClient < BaseClient

    HEADERS = %i(url status effective_url redirect_count).freeze

    def run
      follow = App.preferences[:follow_redirect] || true
      request = Typhoeus::Request.new(url, followlocation: follow)
      request.run
    end

    def to_h
      @parsed[:url] = url
      @parsed[:status] = response.options[:response_code]
      @parsed[:effective_url] = response.options[:effective_url]
      @parsed[:redirect_count] = response.options[:redirect_count]
      @parsed
    end
  end
end