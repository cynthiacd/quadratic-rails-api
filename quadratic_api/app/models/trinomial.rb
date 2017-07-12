class Trinomial < ApplicationRecord
  belongs_to :user
  after_initialize :create_roots

  def create_roots
    self.root1 ||= rand(1..13)
    self.root2 ||= rand(1..13)
    self.save
  end

  def generate_random_trinomial
    random_pattern = [
      "plus_plus",
      "minus_plus",
      "minus_minus",
      "plus_minus",
      "diff_sq",
      "plus_dbl_sq",
      "minus_dbl_sq",
      "gcf",
      "prime"
    ].sample

    return self.generate_trinomial(random_pattern)
  end

  def generate_custom_trinomial
    user = self.user
    report = user.generate_mastery_report
    p report
    lowest = report.min_by { |pattern, level| level } #returns array [:pattern, level]
    p lowest
    return self.generate_trinomial(lowest[0].to_s)
  end

  # def generate_plus_plus
  #   self.generate_b_and_c
  #   self.generate_solutions
  #
  #   return {
  #     pattern: "plus_plus",
  #     general_form: "+ #{@b}x + #{@c}",
  #     solution1: @solution1,
  #     solution2: @solution2
  #   }
  # end
  #
  # def generate_minus_plus
  #   self.root1 *= -1
  #   self.root2 *= -1
  #   self.generate_b_and_c
  #   self.generate_solutions
  #
  #   return {
  #     pattern: "minus_plus",
  #     general_form: "- #{@b.abs}x + #{@c}",
  #     solution1: @solution1,
  #     solution2: @solution2
  #   }
  # end
  #
  # def generate_minus_minus
  #   self.root1 > self.root2 ? self.root1 *= -1 : self.root2 *= -1
  #   self.generate_b_and_c
  #   self.generate_solutions
  #
  #   return {
  #     pattern: "minus_minus",
  #     general_form: "- #{@b.abs}x - #{@c.abs}",
  #     solution1: @solution1,
  #     solution2: @solution2
  #   }
  # end
  #
  # def generate_plus_minus
  #   self.root2 > self.root1 ? self.root1 *= -1 : self.root2 *= -1
  #   self.generate_b_and_c
  #   self.generate_solutions
  #
  #   return {
  #     pattern: "plus_minus",
  #     general_form: " + #{@b}x - #{@c.abs}",
  #     solution1: @solution1,
  #     solution2: @solution2
  #   }
  # end

  # def generate_diff_squares
  #   # your don't need two unique roots
  #   self.root2 = -1* self.root1
  #   self.generate_b_and_c
  #   self.save
  #   # diff_sq
  #   return {
  #     pattern: "diff_sq",
  #     general_form: "- #{self.root1.abs2}",
  #     solution1: "=(x-#{self.root1})(x+#{self.root1})",
  #     solution2: "=(x+#{self.root1})(x-#{self.root1})"
  #   }
  # end
  #
  # def generate_plus_dbl_sq
  #   self.root2 = self.root1
  #   self.generate_b_and_c
  #   self.save
  #
  #   return {
  #     pattern: "plus_dbl_sq",
  #     general_form: "+ #{self.root1 * 2}x + #{self.root1.abs2}",
  #     solution1: "=(x+#{self.root1})(x+#{self.root1})",
  #     solution2: "=(x+#{self.root1})^2"
  #   }
  # end
  #
  # def generate_minus_dbl_sq
  #   self.root1 *= -1
  #   self.root2 = self.root1
  #   self.generate_b_and_c
  #   self.save
  #
  #   return {
  #     pattern: "minus_dbl_sq",
  #     general_form: "- #{self.root1.abs * 2}x + #{self.root1.abs2}",
  #     solution1: "=(x-#{self.root1.abs})(x-#{self.root1.abs})",
  #     solution2: "=(x-#{self.root1.abs})^2"
  #   }
  # end
  #
  # # this is tricky - really need a way to geneate all general forms and then have signs fixed ...
  # def generate_gcf
  #   trinomial = self.generate_random_trinomial
  #   # p trinomial
  #   a = rand(2..5)
  #   @b *= a
  #   @c *= a
  #
  #   general_form = fix_signs("+ #{@b}x + #{@c}")
  #   # working when I put this here - need to have  method fix_signs do this
  #   # general_form = general_form.sub("+ -", "- ")
  #   # p general_form
  #
  #   trinomial[:solution1][1] = "#{a}("
  #   trinomial[:solution2][1]= "#{a}("
  #
  #   trinomial[:pattern] = "gcf"
  #   trinomial[:general_form] = general_form
  #   trinomial[:a] = a
  #   # trinomial[:b] = @b
  #   # trinomial[:c] = @c
  #
  #   return trinomial
  # end
  #
  # def generate_prime
  #   # another way generate array of 30 known prime factors
  #   trinomial = self.generate_random_trinomial
  #   # will this work? or will there be some random cases where this still returns
  #   # a factorable trinomial
  #   # another method - swap the signs?
  #   @b -= 3
  #   general_form = fix_signs("+ #{@b}x + #{@c}")
  #   # p general_form
  #   trinomial[:pattern] = "primes"
  #   trinomial[:general_form] = general_form
  #   trinomial[:solution1]="prime"
  #   trinomial[:solution2]="NA"
  #   return trinomial
  # end
  #
  # def generate_zeros_and_ones
  # end
  #
  # def generate_a_greater_one
  # end

  def generate(sign1, sign2)
    self.generate_b_and_c
    self.generate_solutions
    return {
      pattern: self.pattern,
      general_form: "#{sign1} #{@b.abs}x #{sign2} #{@c.abs}",
      solution1: @solution1,
      solution2: @solution2
    }

  end

  def generate_b_and_c
    @b = self.root1 + self.root2
    @c = self.root1 * self.root2
  end

  def generate_solutions
    @solution1 = self.fix_signs("=(x+#{self.root1})(x+#{self.root2})")
    @solution2 = self.fix_signs("=(x+#{self.root2})(x+#{self.root1})")
  end

  # how do I get make this method work to fix all signs for all expressions
  def fix_signs(expression)
    until expression == expression.sub("+-", "-") && expression == expression.sub("+ -", "- ")
      expression = expression.sub("+-", "-")
      expression = expression.sub("+ -", "- ")
    end

    return expression
  end

  def generate_trinomial(pattern)
    case pattern
    when "plus_plus"
      # self.pattern = pattern
      # return self.generate_problem(sign1, sign2)
      return self.generate("+", "+")
    when "minus_plus"
      self.root1 *= -1
      self.root2 *= -1
      return self.generate_minus_plus
    when "minus_minus"
      return self.generate_minus_minus
    when "plus_minus"
      return self.generate_plus_minus
    # when "diff_sq"
      # return self.generate_diff_squares
    # when "plus_dbl_sq"
      # return self.generate_plus_dbl_sq
    # when "minus_dbl_sq"
      # return self.generate_minus_dbl_sq
    # when "gcf"
      # return self.generate_gcf
    # when "prime"
      # return self.generate_prime
    end
  end
end
