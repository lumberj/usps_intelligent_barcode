require 'USPS-intelligent-barcode/CodewordMap'

# The namespace for everything in this gem.

module Imb

  # This class represents a barcode.  It is the main class: you will
  # probably seldom need to touch any of the others.

  class Barcode

    include Memoizer

    # The barcode id, an instance of BarcodeId
    attr_reader :barcode_id

    # The service type, an instance of ServiceType
    attr_reader :service_type

    # The mailer id, an instance of MailerId
    attr_reader :mailer_id

    # The serial number, and instance of SerialNumber
    attr_reader :serial_number

    # The routing code, an instance of RoutingCode
    attr_reader :routing_code

    # === Arguments

    # * +barcode_id+ - Nominally a String, but can be anything that
    #   BarcodeId::coerce will accept.
    # * +service_type+ - Nominally a String, but can be anything that
    #   ServiceType::coerce will accept.
    # * +mailer_id+ - Nominally a String, but can be anything that
    #   MailerId::coerce will accept.
    # * +serial_number+ - Nominally a String, but can be anything that
    #   SerialNumber::coerce will accept.
    # * +routing_code+ - Nominally a String, but can be anything that
    #   RoutingCode::coerce will accept.

    def initialize(barcode_id,
                   service_type,
                   mailer_id,
                   serial_number,
                   routing_code)
      @barcode_id = BarcodeId.coerce(barcode_id)
      @service_type = ServiceType.coerce(service_type)
      @mailer_id = MailerId.coerce(mailer_id)
      @serial_number = SerialNumber.coerce(serial_number)
      @routing_code = RoutingCode.coerce(routing_code)
      validate_components
    end

    # Return a string that represents the barcode.  Each character of
    # the string will be one of:
    # * 'T' for a tracking mark (neither ascender nor descender)
    # * 'A' for an ascender mark
    # * 'D' for a descender mark
    # * 'F' for a full mark (both ascender and descender)
    # Print the barcode using this string and one of the USPS
    # Intelligent Mail Barcode fonts

    def barcode_letters
      barcode.map { |bar| "TDAF"[bar..bar] }.join
    end
    
    private

    # :stopdoc:
    BAR_MAP = BarMap.new
    CODEWORD_MAP = CodewordMap.new
    # :startdoc:

    def validate_components
      components.each do |component|
        component.validate(long_mailer_id?)
      end
    end

    def components
      [
        @routing_code,
        @barcode_id,
        @service_type,
        @mailer_id,
        @serial_number,
      ]
    end

    def long_mailer_id?
      @mailer_id.long?
    end

    def binary_data
      components.inject(0) do |data, component|
        component.shift_and_add_to(data, long_mailer_id?)
      end
    end
    memoize :binary_data

    def frame_check_sequence
      Crc.crc(binary_data)
    end
    memoize :frame_check_sequence

    def codewords
      codewords = []
      data = binary_data
      data, codewords[9] = data.divmod 636
      8.downto(0) do |i|
        data, codewords[i] = data.divmod 1365
      end
      codewords
    end
    memoize :codewords

    def codewords_with_orientation_in_character_j
      result = codewords.dup
      result[9] *= 2
      result
    end

    def codewords_with_fcs_bit_in_character_a
      result = codewords_with_orientation_in_character_j.dup
      result[0] += 659 if frame_check_sequence[10] == 1
      result
    end      

    def characters
      CODEWORD_MAP.characters(codewords_with_fcs_bit_in_character_a)
    end

    def characters_with_fcs_bits_0_through_9
      characters.each_with_index.map do |character, i|
        if frame_check_sequence[i] == 1
          character ^ 0b1111111111111
        else
          character
        end
      end
    end

    def barcode
      BAR_MAP.barcode(characters_with_fcs_bits_0_through_9)
    end

  end

end
