require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe CodewordMap do

    let(:characters) do
      [
        0x001F, 0x001F, 0x001F, 0x001F, 0x1524, 
        0x01A3, 0x043C, 0x1838, 0x012B, 0x0076,
      ]
    end
    let(:codewords) {[0, 0, 0, 0, 559, 202, 508, 451, 124, 34]}
    let(:codeword_map) {CodewordMap.new}

    specify do
      codeword_map.characters(codewords).should == characters
    end

  end

end
