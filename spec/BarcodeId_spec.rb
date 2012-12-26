require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe BarcodeId do

    describe '::coerce' do

      subject {BarcodeId.coerce(o)}

      context 'BarcodeId' do
        let(:o) {BarcodeId.new(12)}
        its(:to_i) {should == 12}
      end

      context 'String' do
        let(:o) {'12'}
        its(:to_i) {should == 12}
      end

      context 'Integer' do
        let(:o) {12}
        its(:to_i) {should == 12}
      end

      context 'unknown' do
        let(:o) {Object.new}
        specify do
          expect {
            BarcodeId.coerce(o)
          }.to raise_error ArgumentError, 'Cannot coerce to BarcodeId'
        end
      end

    end

    describe '#to_i' do
      let(:value) {23}
      subject {BarcodeId.new(value)}
      its(:to_i) {should == value}
    end

    describe '#=' do
      def o1 ; BarcodeId.new(1) ; end
      def o2 ; 1 ; end
      def o3 ; BarcodeId.new(2) ; end
      def o4 ; Object.new ; end
      specify {o1.should == o1}
      specify {o1.should == o2}
      specify {o1.should_not == o3}
      specify {o1.should_not == o4}
    end

    describe '#most_significant_digit' do
      specify do
        BarcodeId.new(12).most_significant_digit.should == 1
      end
    end

    describe '#least_significant_digit' do
      specify do
        BarcodeId.new(12).least_significant_digit.should == 2
      end
    end

    describe '#validate' do

      let(:long_mailer_id?) {mock 'long_mailer_id?'}

      def validate(value)
        BarcodeId.new(value).validate(long_mailer_id?)
      end

      def self.is_valid(value)
        context "#{value}" do
          specify {validate(value)}
        end
      end

      def self.is_out_of_range(value)
        context "#{value}" do
          specify do
            expect {
              validate(value)
            }.to raise_error ArgumentError, 'Must be 0..94'
          end
        end
      end

      def self.has_bad_least_significant_digit(value)
        context "#{value}" do
          specify do
            expect {
              validate(value)
            }.to raise_error(ArgumentError,
                             'Least significant digit must be 0..4')
          end
        end
      end

      is_out_of_range -1
      is_valid 0
      is_valid 4
      has_bad_least_significant_digit 5
      is_valid 94
      is_out_of_range 95

    end

    describe '#shift_and_add_to' do
      let(:barcode_id) {BarcodeId.new(12)}
      let(:long_mailer_id?) {mock 'long mailer id'}
      specify {barcode_id.shift_and_add_to(1, long_mailer_id?).should == 57}
    end

  end

end
