require 'matrix'

class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

class Table

  class UnsafeCoordinates < StandardError; end

  MAX_NUMBER_OF_ROWS_AND_COLUMNS = 4
  MIN_POSITION_NUMER             = 0
  SAFETY_RANGE                   = MIN_POSITION_NUMER..MAX_NUMBER_OF_ROWS_AND_COLUMNS

  attr_reader :table

  def initialize
    @table = Matrix.zero(MAX_NUMBER_OF_ROWS_AND_COLUMNS.succ)
  end

  def add(x,y,value)
    raise UnsafeCoordinates.new("#{x}, #{y}") unless safe?(x,y)
    @table[x,y]=value
  end

  def inspect
<<-Matrix


              N
      4 - #{@table[4,0]}  #{@table[4,1]}  #{@table[4,2]}  #{@table[4,3]}  #{@table[4,4]}
      3 - #{@table[3,0]}  #{@table[3,1]}  #{@table[3,2]}  #{@table[3,3]}  #{@table[3,4]}
  W   2 - #{@table[2,0]}  #{@table[2,1]}  #{@table[2,2]}  #{@table[2,3]}  #{@table[2,4]}  E
      1 - #{@table[1,0]}  #{@table[1,1]}  #{@table[1,2]}  #{@table[1,3]}  #{@table[1,4]}
      00- #{@table[0,0]}  #{@table[0,1]}  #{@table[0,2]}  #{@table[0,3]}  #{@table[0,4]}
              S


Matrix
  end

  private
  def safe?(x,y)
    SAFETY_RANGE.cover? x and SAFETY_RANGE.cover? y
  end
end