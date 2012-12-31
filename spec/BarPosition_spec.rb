require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe BarPosition do

    describe '#map' do

      let(:ascender_bit) {mock 'ascender bit'}
      let(:descender_bit) {mock 'descender bit'}
      let(:characters) {mock 'array of characters'}
      let(:descender_character_position) {mock CharacterPosition}
      let(:ascender_character_position) {mock CharacterPosition}
      let(:bar_position) do
        BarPosition.new(descender_character_position,
                        ascender_character_position)
      end
      let(:bar_symbol) {mock BarSymbol}

      before(:each) do
        descender_character_position.stub(:extract_bit_from_characters)\
        .with(characters)\
        .and_return(descender_bit)
        ascender_character_position.stub(:extract_bit_from_characters)\
        .with(characters)\
        .and_return(ascender_bit)
        BarSymbol.stub(:make)\
        .with(ascender_bit, descender_bit)\
        .and_return(bar_symbol)
      end

      specify do
        bar_position.map(characters).should == bar_symbol
      end

    end

  end

end
