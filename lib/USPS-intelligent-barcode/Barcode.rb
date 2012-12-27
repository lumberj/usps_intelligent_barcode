module Imb

  class Barcode

    include Memoizer

    attr_reader :barcode_id
    attr_reader :service_type
    attr_reader :mailer_id
    attr_reader :serial_number
    attr_reader :routing_code

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
    
    def barcode_letters
      barcode.map { |bar| "TDAF"[bar..bar] }.join
    end
    
    private

    BAR_MAP = BarMap.new
    CODEWORD_MAP = CodewordMap.new

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
