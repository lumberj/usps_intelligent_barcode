require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe NumericConversions do

    include NumericConversions

    describe '#numeric_to_bytes' do

      specify do
        expect(numeric_to_bytes(0x1234)).to eq([0x12, 0x34])
      end

      specify do
        expect(numeric_to_bytes(0x1234, 3)).to eq([0, 0x12, 0x34])
      end

    end

  end

end
