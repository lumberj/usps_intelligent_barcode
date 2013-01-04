require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe MailerId do

    describe '::coerce' do

      subject {MailerId.coerce(o)}

      context 'MailerId' do
        let(:o) {MailerId.new(12)}
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
            MailerId.coerce(o)
          }.to raise_error ArgumentError, 'Cannot coerce to MailerId'
        end
      end

    end

    describe '#to_i' do
      let(:value) {23}
      subject {MailerId.new(value)}
      its(:to_i) {should == value}
    end

    describe '#=' do
      def o1 ; MailerId.new(1) ; end
      def o2 ; 1 ; end
      def o3 ; MailerId.new(2) ; end
      def o4 ; Object.new ; end
      specify {o1.should == o1}
      specify {o1.should == o2}
      specify {o1.should_not == o3}
      specify {o1.should_not == o4}
    end

    describe '#validate' do

      let(:long_mailer_id?) {mock 'long_mailer_id?'}

      def validate(value)
        MailerId.new(value).validate(long_mailer_id?)
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
            }.to raise_error(ArgumentError,
                             'Must be 0..899999 or 900000000..999999999')
          end
        end
      end

      is_out_of_range -1
      is_valid 0
      is_valid 899_999
      is_out_of_range 1_000_000
      is_out_of_range 899_999_999
      is_valid 900_000_000
      is_valid 999_999_999
      is_out_of_range 1_000_000_000

    end

    describe '#long?' do

      subject {MailerId.new(value)}

      context 'short' do
        let(:value) {0}
        its(:long?) {should be_false}
      end

      context 'long' do
        let(:value) {900_000_000}
        its(:long?) {should be_true}
      end

    end

    describe '#shift_and_add_to' do

      context 'short' do
        let(:mailer_id) {MailerId.new(999999)}
        let(:long_mailer_id?) {false}
        specify {mailer_id.shift_and_add_to(1, long_mailer_id?).should == 1999999}
      end

      context 'long' do
        let(:mailer_id) {MailerId.new(999999999)}
        let(:long_mailer_id?) {true}
        specify {mailer_id.shift_and_add_to(1, long_mailer_id?).should == 1999999999}
      end

    end

  end

end
