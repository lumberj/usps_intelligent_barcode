module Imb

  class BarPosition

    def initialize(descender_character_position, ascender_character_position)
      @descender_character_position = descender_character_position
      @ascender_character_position = ascender_character_position
    end

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
