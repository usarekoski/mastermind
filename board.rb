class Board

  require 'colorize'

  LOGO             = "Mastermind".colorize(:white)
  KEY_PEG_DEFAULT  = "\u25CF".colorize(:black)
  KEY_PEG_RED      = "\u25CF".colorize(:red)
  KEY_PEG_WHITE    = "\u25CF".colorize(:white)
  CODE_PEG_DEFAULT = "\u2B24".colorize(:black)

  CODE_COLORS = [:red, :green, :yellow, :blue, :magenta, :white]
  CODE_PEGS =
    CODE_COLORS.map { |color| [color, "\u2B24".colorize(color)] }.to_h

  class Row

    attr_reader :guess_numbers

    def initialize
      @guess_numbers = []
      @guess = Array.new(4, CODE_PEG_DEFAULT)
      @feedback_numbers = []
      @feedback = Array.new(4, KEY_PEG_DEFAULT)
    end

    def give_feedback(color_and_position, color)
      @feedback_numbers = [color_and_position, color]
      empty = 4 - (color_and_position + color)
      @feedback = [KEY_PEG_RED]*color_and_position + [KEY_PEG_WHITE]*color 
      @feedback += [KEY_PEG_DEFAULT]*empty
    end

    def make_guess(numbers)
      @guess_numbers = numbers
      colors = numbers.map { |n| CODE_COLORS[n] }
      @guess = colors.map { |key| CODE_PEGS[key] }
    end

    def to_s
      @feedback[0, 2].join(" ") + "\n" + @feedback[2, 2].join(" ") \
        + "  " + @guess.join(" ")
    end

  end

  def initialize
    @rows = (1..12).map {|_| Row.new}.to_a
    @current_row_index = 0
    @secret_code_numbers = []
    @secret_code = Array.new(4, CODE_PEG_DEFAULT)
  end

  def current_row
    @rows[@current_row_index]
  end

  def to_s
    `clear` + LOGO  + "\n" \
      + @rows.reverse.map(&:to_s).join("\n")
  end

  def next_row?
    if @current_row_index < 11
      @current_row_index += 1
      return true
    else
      return false
    end
  end

  def set_secret_code(numbers)
    @secret_code_numbers = numbers
    colors = numbers.map { |n| CODE_COLORS[n] }
    @secret_code = colors.map { |key| CODE_PEGS[key] }
  end

  def is_correct?
    return current_row.guess_numbers.eql?(@secret_code_numbers)
  end

  def colors_to_s
    colors = CODE_COLORS.map { |k| CODE_PEGS[k] }
    colors.zip((1..6).to_a).map { |x| x[1].to_s + " => " + x[0] }.join("   ")
  end

end

