module Graphics

  require 'colorize'

  LOGO             = "Mastermind".colorize(:white)
  KEY_PEG_DEFAULT  = "\u25CF".colorize(:black)
  KEY_PEG_RED      = "\u25CF".colorize(:red)
  KEY_PEG_WHITE    = "\u25CF".colorize(:white)
  CODE_PEG_DEFAULT = "\u2B24".colorize(:black)

  CODE_COLORS = [:red, :green, :yellow, :blue, :magenta, :white]
  CODE_PEGS =
    CODE_COLORS.map { |color| [color, "\u2B24".colorize(color)] }
               .to_h

  def colors_to_s
    colors = CODE_COLORS.map { |k| CODE_PEGS[k] }
    colors.zip((1..6).to_a).map { |x| x[1].to_s + " => " + x[0] }.join("   ")
  end

end

