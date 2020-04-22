class UrlValidator
  attr_reader :uri

  def initialize(url)
    @uri = URI(url)
  end

  def validate
    !!(uri.scheme && uri.host)
  end
end
