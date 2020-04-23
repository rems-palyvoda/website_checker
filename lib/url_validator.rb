module App
  class UrlValidator
    DEFAULT_SCHEME = 'https://'.freeze

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def valid?
      add_scheme unless has_scheme?
      first_condition = !!(url =~ /\A#{URI::regexp}\z/)
      second_condition = URI(url).respond_to?(:request_uri)
      first_condition && second_condition
    end

    def to_s
      prepare
    end

    private

    def has_scheme?
      !!URI(url).scheme
    end

    def add_scheme
      @url = has_scheme? ? url : "#{scheme}#{url}"
    end

    def scheme
      return DEFAULT_SCHEME unless App.preferences
      return DEFAULT_SCHEME unless App.preferences[:scheme]
      App.preferences[:scheme]
    end
  end
end
