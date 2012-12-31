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

    # Given an array of characters, return a symbol for this
    # barcode position.
    # @param [[Integer]] characters character codes
    # @return [BarSymbol] symbol code

    def map(characters)
      BarSymbol.make(ascender_bit(characters),
                     descender_bit(characters))
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
