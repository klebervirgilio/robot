class Game
  ACTIONS  =  %i[place report move right left]

  def initialize
    @move_robot ||= RobotMoviments.new
  end

  def place point=""
    move_robot.to(point)
  end

  def move _
    move_robot.forward
  end

  def right _
    move_robot.to.right
  end

  def left _
    move_robot.to.left
  end

  def report _
    move_robot.report
  end

  def respond_to? meth
    return true if game_action? meth
    super
  end

  private
  attr_reader :move_robot

  def game_action? meth
    ACTIONS.include? meth.to_s.downcase.to_sym
  end

  def method_missing(meth, *args, &block)
    if game_action? meth, *args
      plublic_send meth.to_s.downcase.to_sym
    else
      super
    end
  end
end