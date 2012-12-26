require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe Barcode do

    let(:barcode) do
      Barcode.new(barcode_id,
                  service_type,
                  mailer_id,
                  serial_number,
                  routing_code)
    end
    subject {barcode}

    describe 'Examples from USPS-B-3200 rev. G, Appendix B' do

      describe '#1' do

        let(:barcode_id) {'01'}
        let(:service_type) {'234'}
        let(:mailer_id) {'567094'}
        let(:serial_number) {'987654321'}
        let(:routing_code) {nil}

        its(:binary_data) {should == 0x00000000001122103B5C2004B1}
        its(:frame_check_sequence) {should == 0x051}
        its(:codewords) do
          should == [0, 0, 0, 0, 559, 202, 508, 451, 124, 17]
        end
        its(:codewords_with_orientation_in_character_j) do
          should == [0, 0, 0, 0, 559, 202, 508, 451, 124, 34]
        end
        its(:codewords_with_fcs_bit_in_character_a) do
          should == [0, 0, 0, 0, 559, 202, 508, 451, 124, 34]
        end
        its(:characters) do
          should == [
            0x001F, 0x001F, 0x001F, 0x001F, 0x1524, 
            0x01A3, 0x043C, 0x1838, 0x012B, 0x0076,
          ]
        end
        its(:characters_with_fcs_bits_0_through_9) do
          should == [
            0x1FE0, 0x001F, 0x001F, 0x001F, 0x0ADB,
            0x01A3, 0x1BC3, 0x1838, 0x012B, 0x0076,
          ]
        end
        its(:barcode_letters) do
          should == ('ATTFATTDTTADTAATTDTDTATTDAFDDFADF'\
                     'DFTFFFFFTATFAAAATDFFTDAADFTFDTDT')
        end

      end

      describe '#2' do

        let(:barcode_id) {'01'}
        let(:service_type) {'234'}
        let(:mailer_id) {'567094'}
        let(:serial_number) {'987654321'}
        let(:routing_code) {'01234'}

        its(:binary_data) {should == 0x0000000D138A87BAB5CF3804B1}
        its(:frame_check_sequence) {should == 0x065}
        its(:codewords) do
          should == [0, 0, 15, 14, 290, 567, 385, 48, 388, 333]
        end
        its(:codewords_with_orientation_in_character_j) do
          should == [0, 0, 15, 14, 290, 567, 385, 48, 388, 666]
        end
        its(:codewords_with_fcs_bit_in_character_a) do
          should == [0, 0, 15, 14, 290, 567, 385, 48, 388, 666]
        end
        its(:characters) do
          should == [
            0x001F, 0x001F, 0x1D40, 0x0057, 0x0255, 
            0x0724, 0x04E8, 0x009D, 0x030B, 0x0583,
          ]
        end
        its(:characters_with_fcs_bits_0_through_9) do
          should == [
            0x1FE0, 0x001F, 0x02BF, 0x0057, 0x0255,
            0x18DB, 0x1B17, 0x009D, 0x030B, 0x0583,
          ]
        end
        its(:barcode_letters) do
          should == ('DTTAFADDTTFTDTFTFDTDDADADAFADFATD'\
                     'DFTAAAFDTTADFAAATDFDTDFADDDTDFFT')
        end

      end

      describe '#3' do

        let(:barcode_id) {'01'}
        let(:service_type) {'234'}
        let(:mailer_id) {'567094'}
        let(:serial_number) {'987654321'}
        let(:routing_code) {'012345678'}

        its(:binary_data) {should == 0x000202BDC097711204D21804B1}
        its(:frame_check_sequence) {should == 0x606}
        its(:codewords) do
          should == [0, 110, 1113, 1363, 198, 413, 470, 468, 1333, 513]
        end
        its(:codewords_with_orientation_in_character_j) do
          should == [0, 110, 1113, 1363, 198, 413, 470, 468, 1333, 1026]
        end
        its(:codewords_with_fcs_bit_in_character_a) do
          should == [659, 110, 1113, 1363, 198, 413, 470, 468, 1333, 1026]
        end
        its(:characters) do
          should == [
            0x1154, 0x00F8, 0x1E01, 0x0110, 0x019A, 
            0x1298, 0x03A2, 0x03A1, 0x0084, 0x0B11,
          ]
        end
        its(:characters_with_fcs_bits_0_through_9) do
          should == [
            0x1154, 0x1F07, 0x01FE, 0x0110, 0x019A,
            0x1298, 0x03A2, 0x03A1, 0x0084, 0x14EE,
          ]
        end
        its(:barcode_letters) do
          should == ('ADFTTAFDTTTTFATTADTAAATFTFTATDAAA'\
                     'FDDADATATDTDTTDFDTDATADADTDFFTFA')
        end

      end

      describe '#4' do

        let(:barcode_id) {'01'}
        let(:service_type) {'234'}
        let(:mailer_id) {'567094'}
        let(:serial_number) {'987654321'}
        let(:routing_code) {'01234567891'}

        its(:binary_data) {should == 0x016907B2A24ABC16A2E5C004B1}
        its(:frame_check_sequence) {should == 0x751}
        its(:codewords) do
          should == [14, 787, 607, 1022, 861, 19, 816, 1294, 35, 301]
        end
        its(:codewords_with_orientation_in_character_j) do
          should == [14, 787, 607, 1022, 861, 19, 816, 1294, 35, 602]
        end
        its(:codewords_with_fcs_bit_in_character_a) do
          should == [673, 787, 607, 1022, 861, 19, 816, 1294, 35, 602]
        end
        its(:characters) do
          should == [
            0x1234, 0x085C, 0x08E4, 0x0B06, 0x1922, 
            0x1740, 0x0839, 0x1200, 0x0DC0, 0x04D4,
          ]
        end
        its(:characters_with_fcs_bits_0_through_9) do
          should == [
            0x0DCB, 0x085C, 0x08E4, 0x0B06, 0x06DD,
            0x1740, 0x17C6, 0x1200, 0x123F, 0x1B2B,
          ]
        end
        its(:barcode_letters) do
          should == ('AADTFFDFTDADTAADAATFDTDDAAADDTDTT'\
                     'DAFADADDDTFFFDDTTTADFAAADFTDAADA')
        end

      end

    end

    describe '#accessors' do

      let(:barcode) do
        Barcode.new(barcode_id,
                    service_type,
                    mailer_id,
                    serial_number,
                    routing_code)
      end
      subject {barcode}

      context 'when constructed with strings' do
        let(:barcode_id) {'01'}
        let(:service_type) {'234'}
        let(:mailer_id) {'567094'}
        let(:serial_number) {'987654321'}
        let(:routing_code) {'98765432109'}
        its(:barcode_id) {should == 1}
        its(:service_type) {should == 234}
        its(:mailer_id) {should == 567094}
        its(:serial_number) {should == 987654321}
        its(:routing_code) {should == RoutingCode.new(98765, 4321, 9)}
      end

      context 'when constructed with integers' do
        let(:barcode_id) {01}
        let(:service_type) {234}
        let(:mailer_id) {567094}
        let(:serial_number) {987654321}
        let(:routing_code) {[98765, 4321, 9]}
        its(:barcode_id) {should == 1}
        its(:service_type) {should == 234}
        its(:mailer_id) {should == 567094}
        its(:serial_number) {should == 987654321}
        its(:routing_code) {should == RoutingCode.new(98765, 4321, 9)}
      end

    end

  end

end
