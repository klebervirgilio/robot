require 'spec_helper'
require 'logger'

class Logger
  @@std_robot = []

  def self.clear_std_robot!
    @@std_robot = []
  end

  def self.std_robot
    @@std_robot
  end

  private
  def pp msg
    @@std_robot << msg
  end
  alias_method :ppp, :pp
end

describe Logger do
  let(:msg) {'msg'}

  before(:all) {Logger.on!}

  it '.log' do
    subject.log msg
    expect(Logger.std_robot.last).to eq msg
  end

  it '.say' do
    subject.say msg
    expect(Logger.std_robot.last).to eq msg
  end

  it '.warn' do
    subject.warn msg
    expect(Logger.std_robot.last).to eq "WARNING: #{msg}"
  end
end