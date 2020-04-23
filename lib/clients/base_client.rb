module App
  class BaseClient
    attr_reader :url, :response, :parsed

    def initialize(url)
      @url = url
      @response = run
      @parsed = {}
    end

    def run
      raise 'not implemented yet'
    end

    def to_h
      raise 'not implemented yet'
    end
  end
end
