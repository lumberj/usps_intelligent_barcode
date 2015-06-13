require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe CharacterPosition do

    describe '#extract_bit_from_characters' do

      let(:characters) {[1, 2]}

      def extract(character_index, bit_number)
        CharacterPosition.new(character_index, bit_number)\
        .extract_bit_from_characters(characters)
      end

      specify {expect(extract(0, 0)).to eq(1)}
      specify {expect(extract(0, 1)).to eq(0)}
      specify {expect(extract(1, 0)).to eq(0)}
      specify {expect(extract(1, 1)).to eq(1)}

    end

  end

end
