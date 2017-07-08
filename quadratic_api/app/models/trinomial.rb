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
    return { a: 1, b: b, c: c }
    # or could return an array?
    # return [1, b, c]
  end
end
