require 'spec_helper'
require 'table'

describe Table  do
  describe '.add' do
    context 'Safe coordinates' do
      it "should add a point" do
        expect(subject.add(1,1,'Point')).to eq 'Point'
      end
    end
    context 'Unafe coordinates' do
      it "should not add a point" do
        expect{
          subject.add(5,5,'Point')
        }.to raise_error(Table::UnsafeCoordinates)
      end
    end
  end
end