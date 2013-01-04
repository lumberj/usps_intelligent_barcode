require 'USPS-intelligent-barcode/numeric_conversions'

module Imb

  # @!group Internal

  # Calculates the Intelligent Mail Barcode CRC.

  class Crc

    extend NumericConversions

    # Calculate a CRC.
    # @param [Integer] binary_data A 102-bit integer
    # @return [Integer] An 11-bit CRC

    def self.crc(binary_data)
      crc = MASK
      bytes = numeric_to_bytes(binary_data, NUM_INPUT_BYTES)
      crc = crc_byte(crc, bytes.first, LEADING_BITS_TO_IGNORE)
      for byte in bytes[1...NUM_INPUT_BYTES]
        crc = crc_byte(crc, byte, 0)
      end
      crc
    end

    private

    LEADING_BITS_TO_IGNORE = 2
    CRC_BITS = 11
    CRC_MSB_MASK = 1 << (CRC_BITS - 1)
    BITS_PER_BYTE = 8
    POLYNOMIAL = 0x0F35
    MASK = (1 << CRC_BITS) - 1
    NUM_INPUT_BYTES = 13

    def self.crc_byte(crc, byte, leading_bits_to_ignore)
      num_bits = BITS_PER_BYTE - leading_bits_to_ignore
      data = byte << CRC_BITS - BITS_PER_BYTE + leading_bits_to_ignore
      num_bits.times do
        use_polynomial = (crc ^ data) & CRC_MSB_MASK
        crc <<= 1 
        crc ^= POLYNOMIAL if use_polynomial != 0
        crc &= MASK
        data <<= 1
      end
      crc
    end

  end

end
