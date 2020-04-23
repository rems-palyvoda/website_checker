module App
  class UrlValidator
    DEFAULT_SCHEME = 'https://'.freeze

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def has_scheme?
      url.start_with?('https://') || url.start_with?('http://')
    end

    def add_scheme
      @url = has_scheme? ? url : "#{scheme}#{url}"
    end

    def valid?
      !!(url =~ /\A#{URI::regexp}\z/)
    end

    def prepare
      return url if valid?

      add_scheme unless has_scheme?
      url if valid?
    end

    def to_s
      prepare
    end

    def scheme
      App.preferences[:scheme] || DEFAULT_SCHEME
    end
  end
end
