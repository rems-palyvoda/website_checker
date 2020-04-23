module App
  class UrlValidator
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def has_scheme?
      url.start_with?('https://') || url.start_with?('http://')
    end

    def add_default_scheme
      @url = has_scheme? ? url : "http://#{url}"
    end

    def valid?
      !!(url =~ /\A#{URI::regexp}\z/)
    end

    def prepare
      return url if valid?

      add_default_scheme unless has_scheme?
      url if valid?
    end

    def to_s
      prepare
    end
  end
end
