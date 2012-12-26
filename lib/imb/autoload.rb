# class Autoload courtesy of www.databill.com

class Autoload

  def self.setup(*args)
    new(*args).setup
  end

  def initialize(namespace, path)
    @namespace = namespace
    @path = path
  end

  def setup
    autoload_classes_and_modules
    require_utilities
  end

  private

  def require_utilities
    utility_paths.each do |path|
      require File.expand_path(path)
    end
  end

  def autoload_classes_and_modules
    class_and_module_paths.each do |path|
      module_name = File.basename(path).chomp('.rb')
      @namespace.instance_eval do
        autoload(module_name, File.expand_path(path))
      end
    end
  end

  def utility_paths
    ruby_paths - class_and_module_paths - [@path]
  end

  def ruby_paths
    dirname = File.directory?(@path) ? @path : File.dirname(@path)
    paths = Dir[File.join(dirname, '*.rb')]
    paths.reject do |path|
      File.basename(path) == File.basename(@path)
    end
    # Force require statements to happen in a random order to discover
    # missing direct dependencies
    paths.sort_by {rand}
  end

  def class_and_module_paths
    ruby_paths.find_all do |path|
      File.basename(path) =~ /[A-Z]/
    end
  end

end

module Imb ; end

Autoload.setup(Imb, __FILE__)
