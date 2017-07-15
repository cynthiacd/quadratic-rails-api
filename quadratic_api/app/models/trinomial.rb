class Trinomial < ApplicationRecord
  after_initialize :create_roots

  def create_roots
    self.root1 ||= rand(1..13)
    until self.root1 != self.root2 && self.root2 != nil
      self.root2 = rand(1..13)
    end
    self.save
  end

  def generate_random_pattern
    random_pattern = [
      "plus_plus",
      "minus_plus",
      "minus_minus",
      "plus_minus"
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
    self.pattern = pattern

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

    # when "gcf"
    #   return self.generate_gcf

    # when "prime"
    #   return self.generate_prime
    end
  end

  def generate(signs)
    self.generate_b_and_c
    self.save

    return {
      pattern: self.pattern,
      type: "standard",
      general_form: "#{signs[:sign1]} #{@b.abs}x #{signs[:sign2]} #{@c.abs}",
      solution1: "=(x#{signs[:sign1]}#{self.root1.abs})(x#{signs[:sign2]}#{self.root2.abs})",
      solution2: "=(x#{signs[:sign2]}#{self.root2.abs})(x#{signs[:sign1]}#{self.root1.abs})",
      id: self.id
    }
  end

  def generate_b_and_c
    @b = self.root1 + self.root2
    @c = self.root1 * self.root2
  end
  #


  # # this is tricky - really need a way to geneate all general forms and then have signs fixed ...
  # def generate_gcf
  #   trinomial = self.generate_random_trinomial
  #   # p trinomial
  #
  #   a = rand(2..5)
  #   @b *= a
  #   @c *= a
  #
  #   general_form = fix_signs("+ #{@b}x + #{@c}")
  #
  #   trinomial[:pattern] = "gcf"
  #   trinomial[:general_form] = general_form
  #   trinomial[:a] = a
  #
  #   return trinomial
  # end
  # #
  # def generate_prime
  #   # another way generate array of x known prime trinomials and call one # another method - swap the signs?
  #   trinomial = self.generate_random_trinomial
  #
  #   # will this work? or will there be some random cases where this still returns
  #   # a factorable trinomial
  #   @b -= 3
  #   general_form = fix_signs("+ #{@b}x + #{@c}")
  #
  #   trinomial[:general_form] = general_form
  #   trinomial[:solution1]="prime"
  #   trinomial[:solution2]="NA"
  #   return trinomial
  # end

  # def generate_zeros_and_ones
  # end
  #
  # def generate_a_greater_one
  # end
end
