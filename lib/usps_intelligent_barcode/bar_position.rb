module Imb

  # @!group Internal

  # Represents a position (a vertical bar) in the barcode.  This class
  # is internal and may change.
  #
  # Each bar represents two bits, but which two bits it represents is
  # determined by the "Bar to Character Mapping" table in the
  # specification (see Table 22, "Bar to Character Mapping", appendix
  # E) in the specification linked to in the README.
  class BarPosition

    # @param descender_character_position [CharacterPosition]
    # @param ascender_character_position [CharacterPosition]
    def initialize(descender_character_position, ascender_character_position)
      @descender_character_position = descender_character_position
      @ascender_character_position = ascender_character_position
    end

    # Given an array of characters, return a symbol for this
    # barcode position.
    # @param characters [Array<Integer>] character codes
    # @return [BarSymbol] symbol code
    def map(characters)
      BarSymbol.make(
        ascender_bit(characters),
        descender_bit(characters),
      )
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
