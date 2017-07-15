class ATrinomial < ApplicationRecord
  belongs_to :user
  after_initialize :create_roots

  def create_roots
    @a = rand(2..7)
    self.root1 = rand(1..10) 
    self.root2 = rand(1..10)

    # what would the factors look like?
    # should I rename roots? - these are not true roots but are mang of the roots
    # (ax+root1)(x+root2)
    # no factors of a ... (a1x+root1)(a2x+root2)
    self.save
  end

  def generate_ac_trinomial
    b = (@a * self.root2 + self.root1).to_i
    c = (self.root1 * self.root2).to_i

    return {
      pattern: "a_>_1",
      type: "a_>_1",
      a: @a,
      general_form: "+ #{b}x + #{c}",
      solution1: "=(#{@a}x+#{self.root1})(x+#{self.root2})",
      solution2: "=(x+#{self.root2})(#{@a}x+#{self.root1})",
      id: self.id
    }
  end
end

# what about sings should you flip a coint to determine if a root should become postive or negative?
# going to have to do another case statement
# sign = ["+", "-"].sample
# self.root2 *= -1 if sign == "-"
# will genreate a plus_minus or minus_minus pattern but I don't really care on these ones
# (ax+root1)(x-root2)
