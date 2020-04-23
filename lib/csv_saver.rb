module CsvSaver
  def self.save(filename, response)
    CSV.open(filename, 'a') { |csv| csv << response.to_a }
  end
end
