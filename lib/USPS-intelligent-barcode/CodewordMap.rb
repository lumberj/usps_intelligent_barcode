module Imb

  class CodewordMap

    def initialize
      @characters = load_characters
    end

    def characters(codewords)
      codewords.map do |codeword|
        @characters[codeword]
      end
    end

    private

    def load_characters
      YAML.load_file(characters_path)
    end

    def characters_path
      File.expand_path('codeword_to_character_mapping.yml',
                       File.dirname(__FILE__))
    end

  end

end
