require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe BarPosition do

    describe '#map' do

      let(:ascender_bit) {double 'ascender bit'}
      let(:descender_bit) {double 'descender bit'}
      let(:characters) {double 'array of characters'}
      let(:descender_character_position) {double CharacterPosition}
      let(:ascender_character_position) {double CharacterPosition}
      let(:bar_position) do
        BarPosition.new(descender_character_position,
                        ascender_character_position)
      end
      let(:bar_symbol) {double BarSymbol}

      before(:each) do
        allow(descender_character_position).to receive(:extract_bit_from_characters)\
        .with(characters)\
        .and_return(descender_bit)
        allow(ascender_character_position).to receive(:extract_bit_from_characters)\
        .with(characters)\
        .and_return(ascender_bit)
        allow(BarSymbol).to receive(:make)\
        .with(ascender_bit, descender_bit)\
        .and_return(bar_symbol)
      end

      specify do
        expect(bar_position.map(characters)).to eq(bar_symbol)
      end

    end

  end

end
