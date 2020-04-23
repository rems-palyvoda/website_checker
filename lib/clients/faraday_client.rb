module App
  class FaradayClient < BaseClient

    HEADERS = %w(url status phrase error).freeze

    def run
      Faraday.get(url)
    rescue Faraday::ConnectionFailed => e
      e
    end

    def to_h
      @parsed[:url] = url

      if response.is_a? Faraday::Response
        @parsed[:status] = response.status
        @parsed[:reason_phrase] = response.reason_phrase
      elsif Faraday::ConnectionFailed
        @parsed[:error] = response.message
      end

      @parsed
    end
  end
end
