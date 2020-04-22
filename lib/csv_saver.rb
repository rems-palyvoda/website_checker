module CsvSaver
  def self.save(filename, response)
    CSV.open(filename, 'a') { |csv| csv << parse_response(response) }
  end

  def self.parse_response(res)
    [res.env.url, res.status, res.reason_phrase]
  end
end
