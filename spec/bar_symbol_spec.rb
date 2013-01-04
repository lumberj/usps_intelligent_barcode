require File.expand_path('spec_helper', File.dirname(__FILE__))

module Imb

  describe BarSymbol do

    subject {BarSymbol.make(ascender_bit, descender_bit)}

    context 'tracker' do
      let(:ascender_bit) {0}
      let(:descender_bit) {0}
      its(:code) {should eq 0}
      its(:letter) {should eq 'T'}
    end

    context 'descender' do
      let(:ascender_bit) {0}
      let(:descender_bit) {1}
      its(:code) {should eq 1}
      its(:letter) {should eq 'D'}
    end

    context 'ascender' do
      let(:ascender_bit) {1}
      let(:descender_bit) {0}
      its(:code) {should eq 2}
      its(:letter) {should eq 'A'}
    end

    context 'full' do
      let(:ascender_bit) {1}
      let(:descender_bit) {1}
      its(:code) {should eq 3}
      its(:letter) {should eq 'F'}
    end

  end

end
