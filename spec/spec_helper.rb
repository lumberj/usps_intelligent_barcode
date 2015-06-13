if RUBY_VERSION >= '1.9'
  require 'simplecov'
  SimpleCov.start
end

require "rspec/its"

require File.expand_path('../lib/usps_intelligent_barcode', File.dirname(__FILE__))
