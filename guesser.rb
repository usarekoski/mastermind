class AiGuesser

  def guess
    (0..5).to_a.shuffle.take(4)
  end

end

class HumanGuesser

  require_relative 'graphics'
  include Graphics

  def guess
    colors = []
    puts "Give your guess:".colorize(:white)
    puts "Give one number at a time, numbers represent following colors:"
    puts colors_to_s
    until colors.size > 3
      begin
        print "Color #{colors.size + 1}:"
        color = Kernel.gets.chomp.match(/\d+/)[0].to_i
        if color < 1 || color > 6
          raise "wrong size"
        end
      rescue
        puts "Not a valid number. Try again."
      else
        colors.push(color - 1)
      end
    end
    colors
  end

end

