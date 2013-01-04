module Imb

  # @!group Internal

  # Represents the position of one bit in the array of intelligent
  # barcode "characters".

  class CharacterPosition

    # @param [Integer] character_index
    # @param [Integer] bit_number

    def initialize(character_index, bit_number)
      @character_index = character_index
      @bit_number = bit_number
    end

    # Given an array of characters, return the bit for this position.
    # @param [[Integer]] characters
    # @return [Integer] bit (0 or 1)

    def extract_bit_from_characters(characters)
      characters[@character_index][@bit_number]
    end

  end

end
