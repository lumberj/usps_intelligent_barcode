module Imb

  # @!group Internal

  # For a given barcode position, maps to the "character" index and
  # bit number used to drive either the ascender or descender of that
  # position.
  class CharacterPosition

    # Construct an instance.
    #
    # @param character_index [Integer] The character's index within an
    #   array of characters.
    # @param bit_number [Integer] The character's bit number 
    def initialize(character_index, bit_number)
      @character_index = character_index
      @bit_number = bit_number
    end

    # Given an array of characters, return the bit for this position.
    #
    # @param characters [Array<Integer>]
    # @return [Integer] bit (0 or 1)
    def extract_bit_from_characters(characters)
      characters[@character_index][@bit_number]
    end

  end

end
