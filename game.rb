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
    puts "Welcome playing Mastermind"
    puts "Press enter to start the game."
    gets
  end

  def select_role
    selection = ""
    puts `clear`
    puts "Now select if you want to play as a guesser or codemaker."
    loop do
      puts "write 1 for guesser or 2 for codemaker"
      selection = gets.chomp
      break if selection == "1" || selection == "2"
      puts "#{selection} is not a valid option."
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
      puts "You guessed right!"
    else
      puts "You did run out of guesses."
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


