#!/usr/bin/env ruby

require 'faraday'
require 'csv'
require './lib/url_validator'
require './lib/csv_saver'
require './lib/clients/base_client'
require './lib/clients/faraday_client'
require './lib/clients/typhoeus_client'

require 'pry'

module App
  class WebsiteChecker
    attr_reader :source_file, :result_file

    include CsvSaver

    DEFAULT_FILE_NAME = 'websites_to_check.csv'.freeze

    def initialize
      @source_file = open_source_file
      @result_file = create_result_file
    end

    def open_source_file
      CSV.parse(File.read(source_file_name), headers: true)
    rescue Errno::ENOENT => e
      puts e.message
      exit
    end

    def call
      source_file.each do |row|
        url_validator = App::UrlValidator.new(row['URL'])
        next unless url_validator.valid?
        response = http_client.new(url_validator.url)
        CsvSaver.save(result_file, response)
      end
    end

    private

    def prepare_url(url)
      UrlValidator.new(url).prepare
    end

    def create_result_file
      filename = "#{Time.now}_responses.csv"
      CSV.open(filename, 'w') { |csv| csv << http_client::HEADERS }
      filename
    end

    def http_client
      @client ||= case App.preferences[:http_client]
                  when 'Faraday'
                    App::FaradayClient
                  when 'Typhoeus'
                    App::TyphoeusClient
                  else
                    App::FaradayClient # suppose as default
                  end
    end

    def source_file_name
      return DEFAULT_FILE_NAME unless App.preferences[:source_file]
      return DEFAULT_FILE_NAME if App.preferences[:source_file].empty?
      App.preferences[:source_file]
    end
  end
end
