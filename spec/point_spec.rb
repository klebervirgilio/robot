require 'spec_helper'
require 'point'

describe Point do
  subject { Point.new(10000, 10_000_000) }

  describe '::south_west_most_coner' do
    subject { Point.south_west_most_coner }
    its(:coordinates) {should eq [0,0]}
    its(:to_s) {should eq "[0, 0]"}
    its(:x) {should be_zero }
    its(:y) {should be_zero }
  end

  describe '::new' do
    its(:coordinates) {should eq [10000, 10_000_000]}
    its(:to_s) {should eq "[10000, 10000000]"}
    its(:x) {should eq 10_000 }
    its(:y) {should eq 10_000_000 }
  end
end