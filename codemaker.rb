class AiCodemaker

  attr_reader :code

  def initialize
    @code = (0..5).to_a.shuffle.take(4)
  end

  def give_feedback(guess_numbers)
    col_and_pos = guess_numbers
                  .zip(@code)
                  .map { |x| x[1] == x[0] }
    guess_left = feedback_help(guess_numbers, col_and_pos)
    code_left = feedback_help(@code, col_and_pos)
    only_col = guess_left.select do |x|
      if code_left.member?(x)
        code_left.delete_at(code_left.index(x) || code_left.length)
        true
      else
        false
      end
    end
    return [col_and_pos.select { |x|  x }.size, only_col.size]
  end

  private

  def feedback_help(numbers, filter)
    filter.zip(numbers).select { |x| x[0] == false }.map { |x| x[1] }
  end

end

class HumanCodemaker < AiCodemaker

  require_relative 'graphics'
  include Graphics

  def initialize
    @code = select_code
  end

  def select_code
    colors = []
    puts `clear`
    puts "Now select your secret code. It must be 4 colors (can be same colors):".colorize(:white)
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

