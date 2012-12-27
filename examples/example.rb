#!/usr/bin/env ruby

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
