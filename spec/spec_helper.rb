if RUBY_VERSION >= '1.9'
  require 'simplecov'
  SimpleCov.start
end

require "rspec/its"

require File.expand_path('../lib/USPS-intelligent-barcode', File.dirname(__FILE__))
