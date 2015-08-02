class Board

  class Row

    KEY_PEG_DEFAULT = "\u25CF".colorize(:black)
    KEY_PEG_RED =  "\u25CF".colorize(:red)
    KEY_PEG_WHITE =  "\u25CF".colorize(:white)
    CODE_COLORS = [:red, :green, :yellow, :blue, :magenta, :white]
    CODE_PEGS = [:red, :green, :yellow, :blue, :magenta, :white]
                  .group_by {|x| x }
                  .map { |key, value| "\u2B24".colorize(key) }
    CODE_PEG_DEFAULT = "\u2B24".colorize(:black)


    def initialize
      @guess = Array.new(4, CODE_PEG_DEFAULT)
      @feedback = ARrray.new(4, KEY_PEG_DEFAULT)
    end

    def give_feedback(color_and_position, color)
      @feedback = [KEY_PEG_RED]*color_and_position << [KEY_PEG_WHITE]*color
    end

    def make_guess(numbers)
      colors = numbers.map { |n| CODE_COLORS[n] }
      @guess = colors.map { |key| CODE_PEGS[key] }
    end

    def to_s
      @feedback[0,1].join("") + "\n" + @feedback[2,3].join \
        + "  " + @guess.join(" ")
    end

  end

  attr_reader :current_row

  def initialize
    @rows = (1...12).map {|_| Row.new}.to_a
    @current_row = @rows[0]
  end

  def to_s
    @rows.join("\n")
  end


end
