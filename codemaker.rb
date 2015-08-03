class Codemaker

  attr_reader :code

  def initialize
    @code = (0...5).to_a.shuffle.take(4)
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
    filter.zip(numbers).select { |x| x[0] }.map { |x| x[1] }
  end

end

