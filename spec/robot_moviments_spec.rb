require 'spec_helper'
require 'point'
require 'table'
require 'logger'
require 'robot'
require 'cardinal_directions'
require 'robot_moviments'

# Disable logs
Logger.off!

describe RobotMoviments do
  describe 'Game can place the robot send to it a place' do
    context 'when no place is passed' do
      it "should return itself" do
        expect(subject.to).to be_a_instance_of RobotMoviments
      end
    end

    context 'when place is passed' do
      context 'when place is valid' do
        it "should place the robot" do
          subject.to 'p,1,1,e'
          expect(subject.robot.facing).to eq CardinalDirections::EAST
        end
      end
      context 'when place is invalid' do
        it "should not place the robot" do
          expect(subject.to('p,5,5,e')).to eq subject
        end
        it "should not face the robot" do
          expect(subject.to('p,3,4,j')).to eq subject
        end
      end
    end
  end

  describe 'Game can tell to the robot to move foward' do
    context 'when robot wont jump out from the table' do
      it "should move" do
        subject.to 'p,4,4,s'
        subject.forward
        expect(subject.current_point.x).to eq 3
        expect(subject.current_point.y).to eq 4
      end
    end
    context 'when robot will jump out from the table' do
      it "should not move" do
        subject.to 'p,4,4,n'
        subject.forward
        expect(subject.current_point.x).to eq 4
        expect(subject.current_point.y).to eq 4
      end
    end
  end

  describe 'Game can change the facing direction of the robot' do
    describe 'Face to the right' do
      it "shoud sends 'right' to the robot" do
        subject.robot.should_receive(:face_right!)
        subject.right
      end

      it "shoud face to EAST" do
        subject.right
        expect(subject.robot.facing).to eq CardinalDirections::EAST
      end
    end
    describe 'Face to the left' do
      it "shoud sends 'left' to the robot" do
        subject.robot.should_receive(:face_left!)
        subject.left
      end

      it "shoud face to WEST" do
        subject.left
        expect(subject.robot.facing).to eq CardinalDirections::WEST
      end
    end
  end
end
