require 'USPS-intelligent-barcode/CharacterPosition'

module Imb

  class BarMap

    def initialize
      @mapping = load_mapping
    end

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
