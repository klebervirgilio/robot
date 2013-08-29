module CardinalDirections
  ALL = [
    NORTH = 'north',
    EAST  = 'east',
    SOUTH = 'south',
    WEST  = 'west',
  ].freeze

  INITAILS = %w[N S W E]

  class InvalidCardinalDirection < StandardError; end
end