class Trinomial
  attr_accessor :root1, :root2
  def initialize
    @root1 = rand(1..13)
    @root2 = rand(1..13)
  end

  def generate_random_trinomial
    random_number = rand(1..2)
    if random_number == 1
      return self.generate_plus_plus
    elsif random_number == 2
      return self.generate_minus_plus
    end
  end

  def generate_random_trinomial
    random_pattern = ["plus_plus",
                      "minus_plus",
                      "minus_minus",
                      "plus_minus"].sample
    case random_pattern
    when "plus_plus"
      return self.generate_plus_plus
    when "minus_plus"
      return self.generate_minus_plus
    when "minus_minus"
      return self.generate_minus_minus
    when "plus_minus"
      return self.generate_plus_minus
    end
  end

  def generate_plus_plus
    b = @root1 + @root2
    c = @root1 * @root2

    return {
      pattern: "plus_plus",
      general_form: "+ #{b}x + #{c}",
      a: 1,
      b: b,
      c: c,
      solution1: "=(x+#{root1})(x+#{root2})",
      solution2: "=(x+#{root2})(x+#{root1})"
    }
  end

  def generate_minus_plus
    b = -1*(@root1 + @root2)
    c = @root1 * @root2

    return {
      pattern: "minus_plus",
      general_form: " #{b}x + #{c}",
      solution1: "=(x-#{root1})(x-#{root2})",
      solution2: "=(x-#{root2})(x-#{root1})"
    }
  end

  def generate_minus_minus
    if @root1 > @root2
      @root1 *= -1
    else
      @root2 *= -1
    end

    b = @root1 + @root2
    c = @root1 * @root2

    solution1 = self.fix_signs("=(x+#{@root1})(x+#{@root2})")
    solution2 = self.fix_signs("=(x+#{@root2})(x+#{@root1})")

    return {
      pattern: "minus_minus",
      general_form: " #{b}x #{c}",
      solution1: solution1,
      solution2: solution2
    }
  end

  def generate_plus_minus
    if @root2 > @root1
      @root1 *= -1
    else
      @root2 *= -1
    end

    b = @root1 + @root2
    c = @root1 * @root2

    solution1 = self.fix_signs("=(x+#{@root1})(x+#{@root2})")
    solution2 = self.fix_signs("=(x+#{@root2})(x+#{@root1})")

    return {
      pattern: "plus_minus",
      general_form: " +#{b}x #{c}",
      solution1: solution1,
      solution2: solution2
    }
  end

  def fix_signs(expression)
    return expression.sub("+-", "-")
  end
end
