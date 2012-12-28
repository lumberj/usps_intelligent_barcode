require 'USPS-intelligent-barcode/CharacterPosition'

module Imb

  # Maps intelligent barcode "characters" to codes that indicate what
  # type of bar to print at each given position.  This class is
  # internal and may change.

  class BarMap

    # Create.

    def initialize
      @mapping = load_mapping
    end

    # Given an array of intelligent barcode "characters", return an
    # array of codes for each barcode position.  The codes are:
    # * 0 - tracking mark (neither ascending nor descending)
    # * 1 - descending mark
    # * 2 - ascending mark
    # * 3 - full mark (both ascending and descending)

    def barcode(characters)
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
        BarPosition.new(descender_character_position,
                        ascender_character_position)
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
