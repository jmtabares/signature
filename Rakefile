require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
  runtime_env = ENV['ENVIRONMENT'].to_s
  runtime_browser = ENV['BROWSER'].to_s
  result_file = "result_#{runtime_env}_#{runtime_browser}_#{Time.now.strftime('%Y%m%d@%H%M%S')}.html"
  t.cucumber_opts = ['features --format html -o reports/' + result_file + ' --format pretty', '-p', 'default']
end

task :default => :features

