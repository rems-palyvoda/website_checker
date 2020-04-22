require './website_checker'

task :test do
  Dir.glob('./test/*_test.rb').each { |file| require file}
end

task :run do
  WebsiteChecker.new.call
end
