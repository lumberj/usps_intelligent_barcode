module Imb

  class CharacterPosition

    def initialize(character_index, bit_number)
      @character_index = character_index
      @bit_number = bit_number
    end

    def extract_bit_from_characters(characters)
      characters[@character_index][@bit_number]
    end

  end

end
