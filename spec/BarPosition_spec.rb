require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe BarPosition do

    describe '#map' do

      let(:characters) {mock 'array of characters'}
      let(:descender_character_position) {mock CharacterPosition}
      let(:ascender_character_position) {mock CharacterPosition}
      let(:bar_position) do
        BarPosition.new(descender_character_position,
                        ascender_character_position)
      end

      before(:each) do
        descender_character_position.stub(:extract_bit_from_characters)\
        .with(characters).and_return(descender_bit)
        ascender_character_position.stub(:extract_bit_from_characters)\
        .with(characters).and_return(ascender_bit)
      end

      context 'without ascender, without descender' do
        let(:ascender_bit) {0}
        let(:descender_bit) {0}
        specify {bar_position.map(characters).should == 0}
      end

      context 'without ascender, with descender' do
        let(:ascender_bit) {0}
        let(:descender_bit) {1}
        specify {bar_position.map(characters).should == 1}
      end

      context 'with ascender, without descender' do
        let(:ascender_bit) {1}
        let(:descender_bit) {0}
        specify {bar_position.map(characters).should == 2}
      end

      context 'with ascender, with descender' do
        let(:ascender_bit) {1}
        let(:descender_bit) {1}
        specify {bar_position.map(characters).should == 3}
      end

    end

  end

end
