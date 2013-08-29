class RobotMoviments
  attr_reader :logger, :table, :robot, :current_point

  def initialize
    @logger, @robot, @table = Logger.new, Robot.new, Table.new
    swap Point.south_west_most_coner
  end

  def to place=nil
    return self if place.nil? or (match = valid_place?(place)).nil?

    point = Point.new match[:x], match[:y]

    moviment! :point do
      swap point
      begin
        robot.facing = match[:facing]
      rescue CardinalDirections::InvalidCardinalDirection => e
        logger.warn 'Robot did not change facing direction. Unknown Direction #{e.message}'
      end
    end
  end

  def right
    moviment! :right do
      robot.face_right!
    end
  end

  def left
    moviment! :left do
      robot.face_left!
    end
  end

  def forward
    point = current_point.dup
    moviment! :forward do
      case robot.facing
      when CardinalDirections::NORTH
        point.x = (current_point.x == Table::MAX_NUMBER_OF_ROWS_AND_COLUMNS) ? current_point.x : current_point.x.succ
      when CardinalDirections::SOUTH
        point.x = (current_point.x == Table::MIN_POSITION_NUMER)             ? current_point.x : current_point.x.pred
      when CardinalDirections::EAST
        point.y = (current_point.y == Table::MAX_NUMBER_OF_ROWS_AND_COLUMNS) ? current_point.y : current_point.y.succ
      when CardinalDirections::WEST
        point.y = (current_point.y == Table::MIN_POSITION_NUMER)             ? current_point.y : current_point.y.pred
      end

      swap point
    end
  end

  def report
    logger.log "Robot is in #{@current_point.to_s}, faced to #{robot.facing.upcase}. #{@table.inspect}"
  end

  private
  attr_accessor :current_position

  def swap point
    begin
      @table.add(*point.coordinates, robot)
      @table.add(*@current_point.coordinates,0) if @current_point
      @current_point = point
    rescue Table::UnsafeCoordinates => e
      logger.warn "Seems like #{e.message} is not a safe point."
    end
  end

  def valid_place?(place)
    match = place.match(/\Ap,(?<x>[0-4]),(?<y>[0-4]),(?<facing>[nswe])\z/i)
    return nil unless !match.nil? and match[:x] and match[:y] and match[:facing]
    match
  end

  def moviment!(label=nil)
    yield
    logger.log "Moving robot to #{label}... #{@current_point.to_s}, facing: #{robot.facing}" if label
    report
  end
end