module Imb

  # @!group Internal

  # Represents a symbol in the barcode.

  class BarSymbol

    # @param [Integer] ascender_bit (0..1)
    # @param [Integer] descender_bit (0..1)
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

    # @param [Integer] code (0..3)
    # @param [String] letter

    def initialize(code, letter)
      @code = code
      @letter = letter
    end

    private

    TRACKER = BarSymbol.new(0, 'T')
    DESCENDER = BarSymbol.new(1, 'D')
    ASCENDER = BarSymbol.new(2, 'A')
    FULL = BarSymbol.new(3, 'F')

  end

end
