class Trinomial < ApplicationRecord
  belongs_to :user
  after_initialize :create_roots

  def create_roots
    self.root1 ||= rand(1..13)
    self.root2 ||= rand(1..13)
    self.save
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

    b = self.root1 + self.root2
    c = self.root1 * self.root2

    problem_info = {
      pattern: "plus_plus",
      general_form: "+ #{b}x + #{c}",
      a: 1,
      b: b,
      c: c,
      solution1: "=(x+#{self.root1})(x+#{self.root2})",
      solution2: "=(x+#{self.root2})(x+#{self.root1})"
    }

    return problem_info
  end

  def generate_minus_plus
    b = -1*(self.root1 + self.root2)
    c = self.root1 * self.root2

    return {
      pattern: "minus_plus",
      general_form: " #{b}x + #{c}",
      solution1: "=(x-#{self.root1})(x-#{self.root2})",
      solution2: "=(x-#{self.root2})(x-#{self.root1})"
    }
  end

  def generate_minus_minus
    if self.root1 > self.root2
      self.root1 *= -1
    else
      self.root2 *= -1
    end

    b = self.root1 + self.root2
    c = self.root1 * self.root2

    solution1 = self.fix_signs("=(x+#{self.root1})(x+#{self.root2})")
    solution2 = self.fix_signs("=(x+#{self.root2})(x+#{self.root1})")

    return {
      pattern: "minus_minus",
      general_form: " #{b}x #{c}",
      solution1: solution1,
      solution2: solution2
    }
  end

  def generate_plus_minus
    if self.root2 > self.root1
      self.root1 *= -1
    else
      self.root2 *= -1
    end

    b = self.root1 + self.root2
    c = self.root1 * self.root2

    solution1 = self.fix_signs("=(x+#{self.root1})(x+#{self.root2})")
    solution2 = self.fix_signs("=(x+#{self.root2})(x+#{self.root1})")

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
