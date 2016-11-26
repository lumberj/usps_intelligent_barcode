module Imb

  # @!group Internal

  # Represents a symbol in the barcode.  A symbol encodes two bits,
  # and is represented as one of four characters to be printed using
  # one of the USPS Intelligent Barcode fonts.  Each character, when
  # printed using that font, results in a vertical bar having three
  # part: An ascender, which may be present or missing; a descender,
  # which may be present or missing; and between the ascender and the
  # descender, a tracker which is always present.
  #
  # This chart shows the bits being encoded (ascender bit, then
  # descender bit), the code (ASCII character) used for the barcode
  # font, and an ASCII art repsentation of the bar that is printed by
  # that code:
  #
  #     bits:           00          01           10        11
  #
  #     ascender:                                 |         |
  #     tracker:         |           |            |         |
  #     descender:                   |                      |
  #
  #     code:            T           D            A         F
  #     mnemonic:     tracker    descender    ascender    full
  class BarSymbol

    # Return the symbol for a given ascender bit and descender bit.
    #
    # @param ascender_bit  [Integer] 0 or 1
    # @param descender_bit [Integer] 0 or 1
    # @return [BarSymbol]
    def self.make(ascender_bit, descender_bit)
      case [ascender_bit, descender_bit]
      when [0, 0]
        TRACKER
      when [0, 1]
        DESCENDER
      when [1, 0]
        ASCENDER
      when [1, 1]
        FULL
      end
    end

    # @return [Integer] the code for this symbol
    attr_reader :code

    # @return [String] the letter for this symbol
    attr_reader :letter

    # Make an instance.
    #
    # @param code [Integer] Binary number from 0b00 to 0b11.  Bit 1
    #   controls the ascender; bit 0 controls the descender.
    # @param letter [String] The character to print in the barcode
    #   font.
    def initialize(code, letter)
      @code = code
      @letter = letter
    end

    private

    TRACKER = BarSymbol.new(0b00, 'T')
    private_constant :TRACKER
    
    DESCENDER = BarSymbol.new(0b01, 'D')
    private_constant :DESCENDER
    
    ASCENDER = BarSymbol.new(0b10, 'A')
    private_constant :ASCENDER
    
    FULL = BarSymbol.new(0b11, 'F')
    private_constant :FULL

  end

end
