USPS-intelligent-barcode is a pure ruby gem to generate a USPS
Intelligent Mail Barcode.

# FORKED FROM

This project was forked from :

[rtlong/USPS-intellient-barcode](https://github.com/rtlong/USPS-intelligent-barcode)
(github) by Ryan Taylor, in order to add tests and refactor.  It is
_not_ a drop-in replacement: I renamed most methods and classes, and
eliminated the #draw method.

# INSTALL

    $ gem install USPS-intelligent-barcode

# EXAMPLE

    #!/usr/bin/env ruby
    
    require 'imb'
    
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

The tests are known to pass in MRI 1.8.7 and MRI 1.9.3

# WHOAMI

Wayne Conrad <wconrad@yagni.com>

# CREDITS

Thanks to Ryan Taylor for his original work, without which I would
have been lost in the USPS specification.
