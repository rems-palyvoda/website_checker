#!/usr/bin/env ruby

require 'faraday'
require 'csv'
require 'pry'
require './lib/url_validator'

# Faraday.default_adapter = :typhoeus
# CSV.open('test.csv', 'a') { |csv| csv << ['2', 'test'] }

class WebsiteChecker
  attr_reader :file

  def initialize
    @file = CSV.parse(File.read('websites_to_check.csv'), headers: true)
  end

  def call
    file.each do |row|
      url = validate_url(row['URL'])
      response = Faraday.get(url)
      puts "url: #{url}"
      puts "response status: #{response.status}"
      puts "reason phrase: #{response.reason_phrase}"
    rescue Faraday::TimeoutError => e
      puts "#{url} error: #{e.message}"
    rescue Faraday::ConnectionFailed => e
      puts "#{url} error: #{e.message}"
    end
  end

  def validate_url(url)
    UrlValidator.new(url).prepare
  end
end

