module Imb

  # @!group Internal

  # Represents a position (one line) in the barcode.  This class is
  # internal and may change.

  class BarPosition

    # @param [CharacterPosition] descender_character_position
    # @param [CharacterPosition] ascender_character_position

    def initialize(descender_character_position, ascender_character_position)
      @descender_character_position = descender_character_position
      @ascender_character_position = ascender_character_position
    end

    # Given an array of characters, return a symbol code for this
    # barcode position.  The symbol codes are:
    # * 0 - tracking mark (neither ascending nor descending)
    # * 1 - descending mark
    # * 2 - ascending mark
    # * 3 - full mark (both ascending and descending)
    # @param [[Integer]] characters character codes
    # @return [Integer] symbol code

    def map(characters)
      2 * ascender_bit(characters) + descender_bit(characters)
    end

    private

    def descender_bit(characters)
      @descender_character_position.extract_bit_from_characters(characters)
    end

    def ascender_bit(characters)
      @ascender_character_position.extract_bit_from_characters(characters)
    end

  end

end
