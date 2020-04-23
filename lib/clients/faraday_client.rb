module App
  class FaradayClient < BaseClient

    HEADERS = %i(url status reason_phrase error).freeze

    def run
      Faraday.get(url)
    rescue Faraday::ConnectionFailed => e
      e
    end

    def to_h
      @parsed = HEADERS.inject({}){|memo, el| memo[el] = nil; memo}
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
