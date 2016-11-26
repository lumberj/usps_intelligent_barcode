require 'usps_intelligent_barcode/character_position'

# @!group Internal

module Imb

  # Maps intelligent barcode "characters" to the actual barcode.
  class BarMap

    def initialize
      @mapping = load_mapping
    end

    # Given an array of intelligent barcode "characters", return an
    # the symbols for each position.
    #
    # @param characters [Array<Integer>] array of 13-bit "characters"
    #   between 0 and 1364
    # @return [Array<BarSymbol>] array of symbols,
    #   e.g. [BarSymbol::TRACKER, BarSymbol::ASCENDER, ...]
    def symbols(characters)
      @mapping.map do |bar_position|
        bar_position.map(characters)
      end
    end

    private

    def load_mapping
      convert_mapping_data(load_mapping_data)
    end

    def convert_mapping_data(mapping_data)
      mapping_data.map do |descender, ascender|
        descender_character_position = CharacterPosition.new(*descender)
        ascender_character_position = CharacterPosition.new(*ascender)
        BarPosition.new(
          descender_character_position,
          ascender_character_position,
        )
      end
    end

    def load_mapping_data
      YAML.load_file(mapping_path)
    end

    def mapping_path
      File.expand_path('bar_to_character_mapping.yml', File.dirname(__FILE__))
    end

  end

end
