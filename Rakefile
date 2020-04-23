require './website_checker'

task :test do
  Dir.glob('./test/*_test.rb').each { |file| require file}
end

task :run, [:options] do |t, args|
  puts args[:options]
  service = WebsiteChecker.new(args[:options])
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
  puts 'Enter default scheme (1: http / 2: https): '
  options[:default_scheme] = case STDIN.gets.strip
                             when '1'
                               'http'
                             when '2'
                               'https'
                             else
                               puts 'Your value is invalid'
                               exit
                             end

  Rake::Task[:run].invoke(options)
end
