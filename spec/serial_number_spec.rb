require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe SerialNumber do

    describe '::coerce' do

      subject {SerialNumber.coerce(o)}

      context 'SerialNumber' do
        let(:o) {SerialNumber.new(12)}
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
            SerialNumber.coerce(o)
          }.to raise_error ArgumentError, 'Cannot coerce to SerialNumber'
        end
      end

    end

    describe '#to_i' do
      let(:value) {23}
      subject {SerialNumber.new(value)}
      its(:to_i) {should == value}
    end

    describe '#=' do
      def o1 ; SerialNumber.new(1) ; end
      def o2 ; 1 ; end
      def o3 ; SerialNumber.new(2) ; end
      def o4 ; Object.new ; end
      specify {expect(o1).to eq(o1)}
      specify {expect(o1).to eq(o2)}
      specify {expect(o1).not_to eq(o3)}
      specify {expect(o1).not_to eq(o4)}
    end

    describe '#validate' do

      def self.is_valid(value)
        context "#{value}" do
          let(:serial_number) {SerialNumber.new(value)}
          specify {serial_number.validate(long_mailer_id?)}
        end
      end

      def self.is_out_of_range(value)
        context "#{value}" do
          let(:serial_number) {SerialNumber.new(value)}
          specify do
            expect {
              serial_number.validate(long_mailer_id?)
            }.to raise_error ArgumentError, message
          end
        end
      end

      context 'when long mailer id' do
        let(:long_mailer_id?) {true}
        let(:message) {'Must be 0..999999'}
        is_out_of_range -1
        is_valid 0
        is_valid 999_999
        is_out_of_range 1_000_000
      end

      context 'when short mailer id' do
        let(:long_mailer_id?) {false}
        let(:message) {'Must be 0..999999999'}
        is_out_of_range -1
        is_valid 0
        is_valid 999_999_999
        is_out_of_range 1_000_000_000
      end

    end

    describe '#shift_and_add_to' do

      let(:serial_number) {SerialNumber.new(value)}

      def shift_and_add_to
        serial_number.shift_and_add_to(1, long_mailer_id?)
      end

      context 'long mailer id' do
        let(:value) {999_999}
        let(:long_mailer_id?) {true}
        specify {expect(shift_and_add_to).to eq(1_999_999)}
      end

      context 'short mailer id' do
        let(:value) {999_999_999}
        let(:long_mailer_id?) {false}
        specify {expect(shift_and_add_to).to eq(1_999_999_999)}
      end
    end

  end

end
