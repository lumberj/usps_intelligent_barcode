[![Gem Version](https://badge.fury.io/rb/usps_intelligent_barcode.png)](http://badge.fury.io/rb/usps_intelligent_barcode)
[![Dependency Status](https://gemnasium.com/wconrad/usps_intelligent_barcode.svg)](https://gemnasium.com/wconrad/usps_intelligent_barcode)
[![Build Status](https://travis-ci.org/wconrad/usps_intelligent_barcode.png)](https://travis-ci.org/wconrad/usps_intelligent_barcode)
[![Code Climate](https://codeclimate.com/github/wconrad/usps_intelligent_barcode.png)](https://codeclimate.com/github/wconrad/usps_intelligent_barcode)

USPS-intelligent-barcode is a pure ruby gem to generate a USPS IMB
(Intelligent Mail Barcode).  More specifically, it generates the
string of characters you should print using one of the [USPS
Intelligent Barcode
fonts](https://ribbs.usps.gov/onecodesolution/download.cfm).

# ORIGIN

This project was forked from Ryan Taylor's
https://github.com/rtlong/USPS-intelligent-barcode Long, in order to
add tests and refactor.  It is _not_ a drop-in replacement: I renamed
most methods and classes, and eliminated the #draw method.

# INSTALL

    $ gem install USPS-intelligent-barcode

# EXAMPLE

    #!/usr/bin/env ruby
    
    require 'rubygems'
    require 'USPS-intelligent-barcode'
    
    barcode_id = '01'
    service_type = '234'
    mailer_id = '567094'
    serial_number = '987654321'
    routing_code = '01234567891'
    barcode = Imb::Barcode.new(barcode_id,
                               service_type,
                               mailer_id,
                               serial_number,
                               routing_code)
    p barcode.barcode_letters
    # => "AADTFFDFTDADTAADAATFDTDDAAADDTDTTDAFADADDDTFFFDDTTTADFAAADFTDAADA"

# STANDARD

This gem is based upon standard
[USPS-B-3200G](https://ribbs.usps.gov/intelligentmail_mailpieces/documents/tech_guides/SPUSPSG.pdf)

# RUBY VERSIONS

These Ruby versions are supported (these are the rvm platform names):

* jruby-1.7
* ruby-1.9.3
* ruby-2.0
* ruby-2.1
* ruby-2.2

For ruby-1.8.7 please see the deprecated
[USPS-intelligent-barcode](https://rubygems.org/gems/USPS-intelligent-barcode)
gem.

# WHOAMI

Wayne Conrad <kf7qga@gmail.com>

# CREDITS

Thanks to Ryan Taylor Long for his original work, without which I
would have been lost in the USPS specification.
