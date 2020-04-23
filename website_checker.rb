#!/usr/bin/env ruby

require 'faraday'
require 'csv'
require './lib/url_validator'
require './lib/csv_saver'
require './lib/response_handler'

require 'pry'

# Faraday.default_adapter = :typhoeus
module App
  class WebsiteChecker
    attr_reader :source_file, :result_file

    include CsvSaver

    RESULT_HEADERS = %w(url status phrase error)

    def initialize
      @source_file = CSV.parse(File.read('websites_to_check.csv'), headers: true)
      @result_file = create_result_file
    end

    def open_source_file(file_name)
      CSV.parse(File.read(file_name), headers: true)
    rescue Errno::ENOENT => e
      puts e.message
      exit
    end

    def call
      source_file.each do |row|
        url = prepare_url(row['URL'])
        response = ResponseHandler.new(url).to_h
        CsvSaver.save(result_file, response)
      end
    end

    def prepare_url(url)
      UrlValidator.new(url).prepare
    end

    def create_result_file
      filename = "#{Time.now}_responses.csv"
      CSV.open(filename, 'w') { |csv| csv << RESULT_HEADERS }
      filename
    end
  end
end
