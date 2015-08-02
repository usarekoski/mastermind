class Game
  require_relative 'board'
  require_relative 'guesser'
  require_relative 'codemaker'

  def initialize
    @board = Board.new
    @codemaker = Codemaker.new
    welcome
    create_player
    play
  end

  def welcome
    puts "Mastermind"
  end

  def create_player
    @player = Guesser.new
  end

  def play
    until game_over?
      puts @board.to_s
      puts "Give your guess"
      get_guess
      @codemaker.give_feedback
      break unless @board.next_row?
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

  def game_over?
    @board.current_row.is_correct?
  end

end

