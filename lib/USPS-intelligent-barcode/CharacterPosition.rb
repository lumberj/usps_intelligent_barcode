module Imb

  # Represents the position of one bit in the array of intelligent
  # barcode "characters".  This class is internal and may change.

  class CharacterPosition

    # Create.

    def initialize(character_index, bit_number)
      @character_index = character_index
      @bit_number = bit_number
    end

    # Given an array of characters, return the bit for this position.

    def extract_bit_from_characters(characters)
      characters[@character_index][@bit_number]
    end

  end

end
