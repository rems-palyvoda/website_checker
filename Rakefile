require './website_checker'

task :test do
  Dir.glob('./test/*_test.rb').each { |file| require file}
end

task :run do
  service = WebsiteChecker.new
  puts "Going to check #{service.source_file.size} sites..."
  start_time = Time.now
  service.call
  end_time = Time.now
  puts "Process has been finished."
  puts "It took #{end_time - start_time} seconds."
  puts "Output file: #{service.result_file}"
end
