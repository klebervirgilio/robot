class Point
  attr_accessor :x, :y

  def initialize(x=0, y=0)
    @x, @y = x.to_i, y.to_i
  end

  def self.south_west_most_coner
    new(0, 0)
  end

  def coordinates
    [x, y]
  end

  def to_s
    "[#{x}, #{y}]"
  end
end