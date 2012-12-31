require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe BarMap do

    let(:characters) do
      [
        0x1FE0, 0x001F, 0x001F, 0x001F, 0x0ADB,
        0x01A3, 0x1BC3, 0x1838, 0x012B, 0x0076,
      ]
    end
    let(:codes) do
      [
        2, 0, 0, 3, 2, 0, 0, 1, 0, 0, 2, 1, 0,
        2, 2, 0, 0, 1, 0, 1, 0, 2, 0, 0, 1, 2,
        3, 1, 1, 3, 2, 1, 3, 1, 3, 0, 3, 3, 3,
        3, 3, 0, 2, 0, 3, 2, 2, 2, 2, 0, 1, 3,
        3, 0, 1, 2, 2, 1, 3, 0, 3, 1, 0, 1, 0,
      ]
    end
    let(:bar_map) {BarMap.new}

    specify do
      bar_map.barcode(characters).map(&:code).should == codes
    end

  end

end
