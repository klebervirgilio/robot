class Logger
  @@on = true

  def self.on!
    @@on = true
  end

  def self.off!
    @@on = false
  end

  def self.on?
    !!@@on
  end

  def log msg
    pp msg if Logger.on?
  end

  def say msg
    ppp msg if Logger.on?
  end

  def warn msg
    pp "WARNING: #{msg}" if Logger.on?
  end

  private
  def pp msg
    puts msg
  end

  def ppp msg
    pirnt msg
  end
end