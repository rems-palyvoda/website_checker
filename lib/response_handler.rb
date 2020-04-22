class ResponseHandler
  attr_reader :url, :response, :parsed

  def initialize(url)
    @url = url
    @response = run
    @parsed = {}
  end

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
