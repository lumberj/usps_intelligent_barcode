module Imb

  # Represents a position (one line) in the barcode.  This class is
  # internal and may change.

  class BarPosition

    # Create.
    # * +descender_character_position+ - the CharacterPosition for the descender
    # * +ascender_character_position* - the CharacterPosition for the ascender

    def initialize(descender_character_position, ascender_character_position)
      @descender_character_position = descender_character_position
      @ascender_character_position = ascender_character_position
    end

    # Given an array of characters, return a code for this barcode
    # position.  The codes are:
    # * 0 - tracking mark (neither ascending nor descending)
    # * 1 - descending mark
    # * 2 - ascending mark
    # * 3 - full mark (both ascending and descending)

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
