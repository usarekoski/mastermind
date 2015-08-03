#!/usr/bin/env ruby

class Game

  require_relative 'board'
  require_relative 'codemaker'
  require_relative 'guesser'
  require 'colorize'

  def initialize
    @board = Board.new
    welcome
    select_role
    set_secret_code
    play
  end

  def welcome
    puts `clear`
    puts "Welcome playing Mastermind.".colorize(:white)
    puts "This is a software version of a board game 'Mastermind',"
    puts "a code-breaking game for two players."
    puts "In this version you can play against computer as a code breaker or"
    puts "as a maker of the code."
    puts "Press enter to continue.".colorize(:red)
    gets
    puts @board.to_s
    puts "This is the gameboard, which consists of 12 rows of circles."
    puts "Big circles on right are guesses,"
    puts "small circles are feedback from a guess from the same row."
    puts "There is six possible colors to choose from when making"
    puts "the code or guessing it."
    puts "The number of red circles in the feedback tell how many circles in a guess"
    puts "has correct color and position. White circles tell how many has only"
    puts "correct color."
    puts "Press enter to start the game.".colorize(:red)
    gets
  end

  def select_role
    selection = ""
    puts `clear`
    puts "Now select if you want to play as a guesser or codemaker.".colorize(:white)
    loop do
      puts "Write 1 for guesser or 2 for codemaker.".colorize(:red)
      selection = gets.chomp
      break if selection == "1" || selection == "2"
      puts "#{selection} is not a valid option.".colorize(:red)
    end
    if selection == "1"
      @codemaker = AiCodemaker.new
      @guesser = HumanGuesser.new
    else
      @codemaker = HumanCodemaker.new
      @guesser = AiGuesser.new(@board)
    end
  end

  def set_secret_code
    @board.set_secret_code(@codemaker.code)
  end

  def play
    loop do
      puts @board.to_s
      get_guess
      give_feedback
      break if game_over? || !@board.next_row?
    end
    puts @board.to_s
    if game_over?
      puts "You guessed right!".colorize(:white)
    else
      puts "You did run out of guesses.".colorize(:red)
    end
  end

  def get_guess
    @board.current_row.make_guess(@guesser.guess)
  end

  def give_feedback
    feedback = @codemaker.give_feedback(@board.current_row.guess_numbers)
    @board.current_row.give_feedback(*feedback)
  end

  def game_over?
    @board.is_correct?
  end

end

if $0 == __FILE__
  Game.new
end


