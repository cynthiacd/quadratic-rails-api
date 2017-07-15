class ATrinomial < ApplicationRecord
  belongs_to :user
  after_initialize :create_roots_and_a

  def create_roots_and_a
    # do you want this to be a db value?
    @a = rand(2..7)
    # this will generate a zero root ...
    self.root1 = rand(-10..10)
    self.root2 = rand(-10..10)
    self.save
  end

  # for this I don't care about the sign patterns so we can generate all four sign patterns
  # and not have to id them
  def generate_random_pattern
    b = (@a * self.root2 + self.root1).to_i
    c = (self.root1 * self.root2).to_i

    return {
      pattern: "a>1",
      type: "a>1",
      a: @a,
      general_form: fix_signs("+ #{b}x + #{c}"),
      solution1: fix_signs("=(#{@a}x+#{self.root1})(x+#{self.root2})"),
      solution2: fix_signs("=(x+#{self.root2})(#{@a}x+#{self.root1})"),
      id: self.id
    }
  end

  def fix_signs(expression)
    until expression == expression.sub("+-", "-") && expression == expression.sub("+ -", "- ")
      expression = expression.sub("+-", "-")
      expression = expression.sub("+ -", "- ")
    end
    return expression
  end
end
