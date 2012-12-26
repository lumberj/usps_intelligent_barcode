require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe RoutingCode do

    describe '::coerce' do

      let(:zip) {85308}
      let(:plus4) {1465}
      let(:delivery_point) {12}

      subject {RoutingCode.coerce(o)}

      shared_examples 'coerces' do
        its(:zip) {should == zip}
        its(:plus4) {should == plus4}
        its(:delivery_point) {should == delivery_point}
      end

      context 'RoutingCode' do
        let(:o) {RoutingCode.new(zip, plus4, delivery_point)}
        it_behaves_like 'coerces'
      end

      context 'nil' do
        let(:o) {nil}
        let(:zip) {nil}
        let(:plus4) {nil}
        let(:delivery_point) {nil}
        it_behaves_like 'coerces'
      end

      context 'string' do

        let(:o) {"#{zip}#{plus4}#{delivery_point}"}

        context 'empty' do
          let(:zip) {nil}
          let(:plus4) {nil}
          let(:delivery_point) {nil}
          it_behaves_like 'coerces'
        end

        context "zip, plu4, delivery_point" do
          it_behaves_like 'coerces'
        end

      end

      context 'array' do
        let(:o) {[zip, plus4, delivery_point]}
        it_behaves_like 'coerces'
      end

      context 'unrecognized' do
        let(:o) {Object.new}
        specify do
          expect {
            RoutingCode.coerce(o)
          }.to raise_error ArgumentError, 'Cannot coerce to RoutingCode'
        end
      end

    end

    describe '#string_to_array' do

      subject(:array) {RoutingCode.string_to_array(s)}

      context 'empty' do
        let(:s) {''}
        it {should == [nil, nil, nil]}
      end

      context 'zip' do
        let(:s) {'85308'}
        it {should == ['85308', nil, nil]}
      end

      context 'zip, plus4' do
        let(:s) {'853081465'}
        it {should == ['85308', '1465', nil]}
      end

      context 'zip, plu4, delivery_point' do
        let(:s) {'85308146502'}
        it {should == ['85308', '1465', '02']}
      end

      context 'non-digits' do
        let(:s) {'(85308 1465 02)'}
        it {should == ['85308', '1465', '02']}
      end

      context 'incorrect length' do
        let(:s) {'1'}
        specify do
          expect {
            array
          }.to raise_error ArgumentError, 'Bad routing code: "1"'
        end
      end

    end

    describe '#convert' do

      subject do
        RoutingCode.new(zip, plus4, delivery_point)
      end

      context 'empty' do
        let(:zip) {nil}
        let(:plus4) {nil}
        let(:delivery_point) {nil}
        its(:convert) {should == 0}
      end

      context 'zip' do
        let(:zip) {85308}
        let(:plus4) {nil}
        let(:delivery_point) {nil}
        its(:convert) {should == 85309}
      end

      context 'zip, plus4' do
        let(:zip) {85308}
        let(:plus4) {1465}
        let(:delivery_point) {nil}
        its(:convert) {should == 853181466}
      end

      context 'zip, plus4, delivery_point' do
        let(:zip) {85308}
        let(:plus4) {1465}
        let(:delivery_point) {2}
        its(:convert) {should == 86308246503}
      end

    end

    describe '#to_a' do
      let(:zip) {85308}
      let(:plus4) {1465}
      let(:delivery_point) {2}
      subject {RoutingCode.new(zip, plus4, delivery_point)}
      its(:to_a) {should == [zip, plus4, delivery_point]}
    end

    describe '#==' do
      def o1 ; RoutingCode.new(85308, 1465, 1) ; end
      def o2 ; [85308, 1465, 1] ; end
      def o3 ; RoutingCode.new(85308, 1465, 2) ; end
      def o4 ; RoutingCode.new(85308, 1466, 1) ; end
      def o5 ; RoutingCode.new(85309, 1465, 1) ; end
      def o6 ; Object.new ; end
      specify {o1.should == o1}
      specify {o1.should == o2}
      specify {o1.should_not == o3}
      specify {o1.should_not == o4}
      specify {o1.should_not == o5}
      specify {o1.should_not == o6}
    end

    describe '#validate' do
      let(:routing_code) {RoutingCode.new(nil, nil, nil)}
      let(:long_mailer_id?) {mock 'long_mailer_id?'}
      specify {routing_code.validate(long_mailer_id?)}
    end

    describe '#shift_and_add_to' do
      let(:routing_code) {RoutingCode.new(85308, 1465, 2)}
      let(:long_mailer_id?) {mock 'long mailer id'}
      specify {routing_code.shift_and_add_to(1, long_mailer_id?).should == 186308246503}
    end

  end

end
