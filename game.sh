#!/usr/bin/env ruby

# Load required files
root_dir = File.dirname(__FILE__)
$:.unshift "#{root_dir}/lib", root_dir

require 'bundler/setup'
Bundler.setup(:default)

Dir['./lib/*'].each{|f| require File.basename(f) }
require 'game'

# Turn on logger
Logger.on!
logger = Logger.new

# Greetings
logger.log "Let's play!"

# Say bye!
Signal.trap("INT") do
  logger.log "\nTerminating..."
  exit(0)
end

# It's such a REPL for GAME - Human interactions
loop do
  # Short remind about available commands
  moves = if @game.nil?
    "([P]LACE,[0-4],[0-4],[NSEW]|[re]port): "
  else
    "([M]OVE|[L]EFT|[R]IGHT|[P]LACE,[0-4],[0-4],[NSEW]|[re]port): "
  end
  logger.say "Which move whould you like to do #{moves}"

  input = STDIN.gets
  input.chomp!

  # Validates input
  meth = case input
  when /\AL(?:eft)?\z/i                       then 'left'   if @game
  when /\AR(?:ight)?\z/i                      then 'right'  if @game
  when /\AM(?:ove)?\z/i                       then 'move'   if @game
  when /\AP(?:lace)?\,
        [#{Table::MIN_POSITION_NUMER}-#{Table::MAX_NUMBER_OF_ROWS_AND_COLUMNS}],
        [#{Table::MIN_POSITION_NUMER}-#{Table::MAX_NUMBER_OF_ROWS_AND_COLUMNS}],
        [#{CardinalDirections::INITAILS.join}]\z/xi  then 'place'
  when /\ARe(?:port)?\z/i                     then 'report'
  when /\A(?:q|exit|bye)\z/i
    logger.log ':) bye!'
    break
  else
    logger.log 'bad format.. sorry'
    next
  end

  # Handle Game
  begin
    @game ||= Game.new if meth
    if @game and @game.respond_to?(meth)
      @game.public_send meth, input
    else
      logger.log 'For the first move, you have to [P]LACE the robot.'
    end
  end
end