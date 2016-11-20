# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

glob = File.join(File.dirname(__FILE__), "rake/*.rb")
Dir[glob].sort.each do |path|
  require path
end
