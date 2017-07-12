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

  # def generate_custom_trinomial
  #   user = self.user
  #   report = user.generate_mastery_report
  #   p report
  #   lowest = report.min_by { |pattern, level| level } #returns array [:pattern, level]
  #   p lowest
  #   return self.generate_trinomial(lowest[0].to_s)
  # end

  def generate_trinomial(pattern)
    # if pattern != "plus_dbl_sq" && pattern != "minus_dbl_sq" && pattern !=
    self.pattern = pattern
    self.generate_b_and_c
    self.generate_solutions

    case pattern
    when "plus_plus"
      return self.generate( { sign1: "+", sign2: "+" } )

    when "minus_plus"
      self.root1 *= -1
      self.root2 *= -1
      return self.generate( { sign1: "-", sign2: "+" } )

    when "minus_minus"
      self.root1 > self.root2 ? self.root1 *= -1 : self.root2 *= -1
      return self.generate( { sign1: "-", sign2: "-" } )

    when "plus_minus"
      self.root2 > self.root1 ? self.root1 *= -1 : self.root2 *= -1
      return self.generate( { sign1: "+", sign2: "-" } )

    when "diff_sq"
      self.root2 = -1* self.root1
      return self.generate_diff_squares

    when "plus_dbl_sq"
      self.root2 = self.root1
      # cause I change the roots I have to recall these methods
      self.generate_b_and_c
      self.generate_solutions
      return self.generate( { sign1: "+", sign2: "+" } )

    when "minus_dbl_sq"
      self.root1 *= -1
      self.root2 = self.root1
      self.generate_b_and_c
      self.generate_solutions
      return self.generate( { sign1: "-", sign2: "+" } )

    when "gcf"
      return self.generate_gcf

    when "prime"
      return self.generate_prime
    end
  end

  def generate(signs)
    return {
      pattern: self.pattern,
      general_form: "#{signs[:sign1]} #{@b.abs}x #{signs[:sign2]} #{@c.abs}",
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

  def generate_diff_squares
    return {
      pattern: self.pattern,
      general_form: "- #{self.root1.abs2}",
      solution1: "=(x-#{self.root1})(x+#{self.root1})",
      solution2: "=(x+#{self.root1})(x-#{self.root1})"
    }
  end

  # # this is tricky - really need a way to geneate all general forms and then have signs fixed ...
  def generate_gcf
    trinomial = self.generate_random_trinomial

    a = rand(2..5)
    @b *= a
    @c *= a

    general_form = fix_signs("+ #{@b}x + #{@c}")

    trinomial[:solution1][1] = "#{a}("
    trinomial[:solution2][1]= "#{a}("

    trinomial[:pattern] = "gcf"
    trinomial[:general_form] = general_form
    trinomial[:a] = a

    return trinomial
  end
  #
  def generate_prime
    # another way generate array of x known prime trinomials and call one
    trinomial = self.generate_random_trinomial

    # will this work? or will there be some random cases where this still returns
    # a factorable trinomial
    # another method - swap the signs?
    @b -= 3
    general_form = fix_signs("+ #{@b}x + #{@c}")

    # trinomial[:pattern] = "primes"
    trinomial[:general_form] = general_form
    trinomial[:solution1]="prime"
    trinomial[:solution2]="NA"
    return trinomial
  end
  #
  # def generate_zeros_and_ones
  # end
  #
  # def generate_a_greater_one
  # end


end
