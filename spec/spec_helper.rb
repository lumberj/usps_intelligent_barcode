begin
  require 'simplecov'
  SimpleCov.start
rescue LoadError
end

require "rspec/its"

require File.expand_path('../lib/usps_intelligent_barcode', File.dirname(__FILE__))
