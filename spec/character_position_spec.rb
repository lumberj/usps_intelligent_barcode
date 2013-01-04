require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe CharacterPosition do

    describe '#extract_bit_from_characters' do

      let(:characters) {[1, 2]}

      def extract(character_index, bit_number)
        CharacterPosition.new(character_index, bit_number)\
        .extract_bit_from_characters(characters)
      end

      specify {extract(0, 0).should == 1}
      specify {extract(0, 1).should == 0}
      specify {extract(1, 0).should == 0}
      specify {extract(1, 1).should == 1}

    end

  end

end
