class Trinomial
  attr_accessor :root1, :root2
  def initialize
    # @trinomial = []
    @root1 = rand(1..13)
    @root2 = rand(1..13)
  end

  def generate_plus_plus
    b = @root1 + @root2
    c = @root1 * @root2
    # return a hash?
    return {
            pattern: "plus_plus",
            general_form: "+ #{b}x + #{c}",
            a: 1,
            b: b,
            c: c,
            solution1: "=(x+#{root1})(x+#{root2})",
            solution2: "=(x+#{root2})(x+#{root1})"}
    # or could return an array?
    # return [1, b, c]
  end
end
