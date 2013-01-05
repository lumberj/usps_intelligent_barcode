# encoding: utf-8

require 'rubygems'

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "USPS-intelligent-barcode"
  gem.homepage = "http://github.com/wconrad/USPS-intelligent-barcode"
  gem.license = "MIT"
  gem.summary = %Q{Generates a USPS Intelligent Mail Barcode.}
  gem.description =
    ("A pure Ruby library to generate a USPS Intelligent "\
     "Mail barcode.  It generates the string of characters "\
     "to print with one of the USPS Intelligent Mail barcode "\
     "fonts.")
  gem.email = "wconrad@yagni.com"
  gem.authors = ["Wayne Conrad"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new do |t|
end
