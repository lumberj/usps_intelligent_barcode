require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe ServiceType do

    describe '::coerce' do

      subject {ServiceType.coerce(o)}

      context 'ServiceType' do
        let(:o) {ServiceType.new(12)}
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
            ServiceType.coerce(o)
          }.to raise_error ArgumentError, 'Cannot coerce to ServiceType'
        end
      end

    end

    describe '#to_i' do
      let(:value) {23}
      subject {ServiceType.new(value)}
      its(:to_i) {should == value}
    end

    describe '#=' do
      def o1 ; ServiceType.new(1) ; end
      def o2 ; 1 ; end
      def o3 ; ServiceType.new(2) ; end
      def o4 ; Object.new ; end
      specify {expect(o1).to eq(o1)}
      specify {expect(o1).to eq(o2)}
      specify {expect(o1).not_to eq(o3)}
      specify {expect(o1).not_to eq(o4)}
    end

    describe '#validate' do

      let(:long_mailer_id?) {double 'long_mailer_id?'}

      def validate(value)
        ServiceType.new(value).validate(long_mailer_id?)
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
            }.to raise_error ArgumentError, 'Must be 0..999'
          end
        end
      end

      is_out_of_range -1
      is_valid 0
      is_valid 999
      is_out_of_range 1000

    end

    describe '#shift_and_add_to' do
      let(:service_type) {ServiceType.new(999)}
      let(:long_mailer_id?) {double 'long mailer id'}
      specify {expect(service_type.shift_and_add_to(1, long_mailer_id?)).to eq(1999)}
    end

  end

end
