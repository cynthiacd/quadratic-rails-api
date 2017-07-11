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
    self.generate_b_and_c
    self.generate_solutions

    return {
      pattern: "plus_plus",
      general_form: "+ #{@b}x + #{@c}",
      solution1: @solution1,
      solution2: @solution2
    }
  end

  def generate_minus_plus
    self.root1 *= -1
    self.root2 *= -1
    self.generate_b_and_c
    self.generate_solutions

    return {
      pattern: "minus_plus",
      general_form: "- #{@b.abs}x + #{@c}",
      solution1: @solution1,
      solution2: @solution2
    }
  end

  def generate_minus_minus
    self.root1 > self.root2 ? self.root1 *= -1 : self.root2 *= -1
    self.generate_b_and_c
    self.generate_solutions

    return {
      pattern: "minus_minus",
      general_form: "- #{@b.abs}x - #{@c.abs}",
      solution1: @solution1,
      solution2: @solution2
    }
  end

  def generate_plus_minus
    self.root2 > self.root1 ? self.root1 *= -1 : self.root2 *= -1
    self.generate_b_and_c
    self.generate_solutions

    return {
      pattern: "plus_minus",
      general_form: " + #{@b}x - #{@c.abs}",
      solution1: @solution1,
      solution2: @solution2
    }
  end

  def generate_diff_squares
    # your don't need two roots - need to resave one
    self.root2 = -1* self.root1
    self.save

    # self.generate_b_and_c
    return {
      pattern: "diff_sq",
      general_form: "- #{self.root1.abs2}",
      solution1: "=(x-#{self.root1})(x+#{self.root1})"
    }

  end

  # def generate_gcf(problem_info)
  # end

  def generate_b_and_c
    @b = self.root1 + self.root2
    @c = self.root1 * self.root2
  end

  def generate_solutions
    @solution1 = self.fix_signs("=(x+#{self.root1})(x+#{self.root2})")
    @solution2 = self.fix_signs("=(x+#{self.root2})(x+#{self.root1})")
  end

  def fix_signs(expression)
    until expression == expression.sub("+-", "-")
      expression = expression.sub("+-", "-")
    end
    return expression
  end
end
