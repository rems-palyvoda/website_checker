require './website_checker'
require './lib/preferences'

task :test do
  Dir.glob('./test/*_test.rb').each { |file| require file}
end

task :run, [:options] do |t, args|
  puts args[:options]
  App.set_preferences(args[:options])

  service = App::WebsiteChecker.new
  puts "Going to check #{service.source_file.size} sites..."
  start_time = Time.now
  service.call
  end_time = Time.now
  puts "Process has been finished."
  puts "It took #{end_time - start_time} seconds."
  puts "Output file: #{service.result_file}"
end

task :interactive do
  options = {}

  puts 'Enter source filename: '
  options[:source_file] = STDIN.gets.strip

  puts 'Enter default scheme (1: http | 2: https): '
  options[:scheme] = case STDIN.gets.strip
                     when '1'
                       'http://'
                     when '2'
                       'https://'
                     else
                       puts 'Your value is invalid'
                       exit
                     end

  puts 'Select http client: (1: Faraday | 2: Typhoeus)'
  options[:http_client] = case STDIN.gets.strip
                          when '1'
                            'Faraday'
                          when '2'
                            'Typhoeus'
                          else
                            puts 'Your value is invalid'
                            exit
                          end

  Rake::Task[:run].invoke(options)
end
