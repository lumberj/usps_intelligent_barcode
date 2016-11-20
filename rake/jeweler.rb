if Gem::Specification::find_all_by_name("jeweler").any?
  
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
    gem.name = "usps_intelligent_barcode"
    gem.homepage = "http://github.com/wconrad/usps_intelligent_barcode"
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

end
