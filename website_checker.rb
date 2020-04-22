#!/usr/bin/env ruby

require 'faraday'
require 'csv'
require 'pry'
require './lib/url_validator'
require './lib/csv_saver'

# Faraday.default_adapter = :typhoeus

class WebsiteChecker
  attr_reader :source_file, :result_file

  include CsvSaver

  RESULT_HEADERS = %w(url status phrase)

  def initialize
    @source_file = CSV.parse(File.read('websites_to_check.csv'), headers: true)
    @result_file = create_result_file
  end

  def call
    source_file.each do |row|
      url = validate_url(row['URL'])
      response = Faraday.get(url)
      CsvSaver.save(result_file, response)
    rescue Faraday::TimeoutError => e
      puts "#{url} error: #{e.message}"
    rescue Faraday::ConnectionFailed => e
      puts "#{url} error: #{e.message}"
    end
  end

  def validate_url(url)
    UrlValidator.new(url).prepare
  end

  def create_result_file
    filename = "#{Time.now}_responses.csv"
    CSV.open(filename, 'w') { |csv| csv << RESULT_HEADERS }
    filename
  end
end

