require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe Crc do

    describe '#crc' do

      specify do
        Crc.new.crc(0x016907B2A24ABC16A2E5C004B1).should == 0x751
      end

      specify do
        Crc.new.crc(0).should == 0x6e0
      end

    end

  end

end
