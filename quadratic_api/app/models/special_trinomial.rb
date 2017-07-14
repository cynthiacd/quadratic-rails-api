class SpecialTrinomial < ApplicationRecord
  belongs_to :user
  after_initialize :create_root

  def create_root
    self.root1 ||= rand(1..13)
    self.save
  end

  def generate_random_pattern
    random_pattern = [
      "diff_sq",
      "plus_dbl_sq",
      "minus_dbl_sq"
    ].sample

    return self.generate_trinomial(random_pattern)
  end

  def generate_trinomial(pattern)
    self.pattern = pattern
    self.save

    case pattern
    when "diff_sq"
      return self.generate_diff_squares
    when "plus_dbl_sq"
      return self.generate( { sign1: "+", sign2: "+" } )
    when "minus_dbl_sq"
      self.root1 *= -1
      return self.generate( { sign1: "-", sign2: "+" } )
    end
  end

  def generate(signs)
    return {
      pattern: self.pattern,
      type: "special",
      general_form: "#{signs[:sign1]} #{2 * self.root1.abs}x #{signs[:sign2]} #{self.root1.abs2}",
      solution1: "=(x#{signs[:sign1]}#{self.root1.abs})(x#{signs[:sign1]}#{self.root1.abs})",
      solution2: "=(x#{signs[:sign1]}#{self.root1.abs})^2",
      id: self.id
    }
  end

  def generate_diff_squares
    return {
      pattern: self.pattern,
      type: "special",
      general_form: "- #{self.root1.abs2}",
      solution1: "=(x-#{self.root1})(x+#{self.root1})",
      solution2: "=(x+#{self.root1})(x-#{self.root1})",
      id: self.id
    }
  end
end
