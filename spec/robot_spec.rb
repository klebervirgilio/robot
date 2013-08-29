require 'spec_helper'
require 'robot'
require 'cardinal_directions'

describe Robot do
  describe 'facing' do
    context 'Valid Cardinal Direction' do
      it "should not face to a new valid direction" do
        subject.facing = CardinalDirections::EAST
        begin
          subject.facing = CardinalDirections::NORTH
        rescue CardinalDirections::InvalidCardinalDirection
        end
        expect(subject.facing).to eq CardinalDirections::NORTH
      end
    end
    context 'Invalid Cardinal Direction' do
      it "should raise an error" do
        expect{
          subject.facing =  'InvalidCardinalDirection'
        }.to raise_error(CardinalDirections::InvalidCardinalDirection)
      end

      it "should not face to an invalid direction" do
        subject.facing = CardinalDirections::EAST
        begin
          subject.facing = 'InvalidCardinalDirection'
        rescue CardinalDirections::InvalidCardinalDirection
        end
        expect(subject.facing).to eq CardinalDirections::EAST
      end
    end
  end

  describe '.face_right' do
    context 'when facing NORTH' do
      it 'should face to EAST' do
        subject.face_right!
        expect(subject.facing).to eq CardinalDirections::EAST
      end
    end

    context 'when facing EAST' do
      it 'should face to SOUTH' do
        subject.facing = CardinalDirections::EAST
        subject.face_right!
        expect(subject.facing).to eq CardinalDirections::SOUTH
      end
    end

    context 'when facing SOUTH' do
      it 'should face to WEST' do
        subject.facing = CardinalDirections::SOUTH
        subject.face_right!
        expect(subject.facing).to eq CardinalDirections::WEST
      end
    end

    context 'when facing WEST' do
      it 'should face to NORTH' do
        subject.facing = CardinalDirections::WEST
        subject.face_right!
        expect(subject.facing).to eq CardinalDirections::NORTH
      end
    end
  end

  describe '.face_left' do
    context 'when facing NORTH' do
      it 'should face to WEST' do
        subject.face_left!
        expect(subject.facing).to eq CardinalDirections::WEST
      end
    end

    context 'when facing WEST' do
      it 'should face to SOUTH' do
        subject.facing = CardinalDirections::WEST
        subject.face_left!
        expect(subject.facing).to eq CardinalDirections::SOUTH
      end
    end

    context 'when facing SOUTH' do
      it 'should face to EAST' do
        subject.facing = CardinalDirections::SOUTH
        subject.face_left!
        expect(subject.facing).to eq CardinalDirections::EAST
      end
    end

    context 'when facing EAST' do
      it 'should face to NORTH' do
        subject.facing = CardinalDirections::EAST
        subject.face_left!
        expect(subject.facing).to eq CardinalDirections::NORTH
      end
    end
  end
end