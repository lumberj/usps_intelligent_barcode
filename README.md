USPS-intelligent-barcode is a pure ruby gem to generate a USPS
Intelligent Mail Barcode (4-State Customer Barcode).

# PROGENITOR

This project was forked from :

[rtlong/USPS-intellient-barcode](https://github.com/rtlong/USPS-intelligent-barcode)
(github) by Ryan Taylor, in order to add tests and refactor.

# STANDARD

The standard this gem is based upon is
[USPS-B-3200G](https://ribbs.usps.gov/intelligentmail_mailpieces/documents/tech_guides/SPUSPSG.pdf)

# RUBY VERSIONS

The tests are known to pass in MRI 1.8.7 and MRI 1.9.3

# COMPATABILITY

This gem is _not_ drop-in compatible with Ryan Taylor's gem: I renamed
most methods and classes, and eliminated the #draw method.

# WHOAMI

Wayne Conrad <wconrad@yagni.com>

# CREDITS

Thanks to Ryan Taylor for his original work, without which I would
have been lost in the USPS specification.
