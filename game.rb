class Game
  require_relative 'board'
  require_relative 'codemaker'

  def initialize
    @board = Board.new
    @codemaker = Codemaker.new
    welcome
    set_secret_code
    play
  end

  def welcome
    puts "Mastermind"
  end

  def set_secret_code
    @board.set_secret_code(@codemaker.code)
  end

  def create_player
    @player = Guesser.new
  end

  def play
    loop do
      puts @board.to_s
      puts "Give your guess"
      get_guess
      give_feedback
      break unless game_over? || @board.next_row?
    end
  end

  def get_guess
    colors = []
    until colors.size > 3
      begin
        color = Kernel.gets.to_i
      rescue
        puts "Not a valid number. Try again."
      else
        colors << color
        puts "color ..."
      end
    end
    @board.current_row.make_guess(colors)
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


