class Robot
  def initialize
    @facing = 0
  end

  def facing
    return CardinalDirections::NORTH unless @facing
    CardinalDirections::ALL.at(@facing)
  end

  def face_left!
    @facing = if @facing.pred >= 0
      @facing.pred
    else
      CardinalDirections::ALL.size.pred
    end
  end

  def face_right!
    @facing = if @facing.succ == CardinalDirections::ALL.size
      0
    else
      @facing.succ
    end
  end

  def inspect
    facing.to_s.upcase[0]
  end

  def to_s
    facing.to_s.upcase[0]
  end


  def facing= direction
    direction = valid_direction?(direction)
    raise CardinalDirections::InvalidCardinalDirection.new(direction) unless direction
    @facing = direction
  end

  private

  def valid_direction?(direction)
    CardinalDirections::ALL.map.with_index{|d,i| i if d =~ /\A#{direction}/i }.compact.last
  end

  def prepare_to_compare(direction)
    direction.to_s.downcase.to_sym
  end
end