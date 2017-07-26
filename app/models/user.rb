require 'bcrypt'

class User < ApplicationRecord
  # include BCrypt
  has_secure_password
  # before_create :generate_confirmation_info

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }

  def update_mastery_levels(problem_info)
    self.total_problems += 1
    pattern_count = problem_info["pattern"] + "_count"
    self[pattern_count] += 1

    if problem_info["score"] == 1
      self.total_problems_correct += 1
    end

    pattern_mastery = problem_info["pattern"] + "_mastery"
    self[pattern_mastery] += problem_info["score"]
    self[pattern_mastery] = 0 if self[pattern_mastery] < 0

    self.save
  end

  # you could divide by 10 - so 100% correlates with a score of +10
  def generate_mastery_report
    report = {}

    patterns = ["plus_plus",
                "plus_minus",
                "minus_plus",
                "minus_minus",
                "diff_sq",
                "plus_dbl_sq",
                "minus_dbl_sq",
                "a_greater_one" ]


    patterns.each do |pattern|
      report[pattern] = ( ( self["#{pattern}_mastery"] / 10.0 ) * 100 ).to_i
    end

    report["total_problems"] = total_problems
    report["total_problems_correct"] = self.total_problems_correct
    return report
  end

  # def generate_confirmation_info
  #   self.confirmation_token = SecureRandom.hex(10)
  #   self.iat = Time.now.utc
  # end

  # # these methods are using BCrypt Gem
  # def password
  #   @password ||= Password.new(password_hash)
  # end
  #
  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end
end

# plus_plus_level = ((self.plus_plus_mastery / 10.0) * 100).to_i #if self.plus_plus_count > 5
# minus_plus_level = ((self.minus_plus_mastery / 10.0) * 100).to_i #if self.minus_plus_count > 5
# plus_minus_level = ((self.plus_minus_mastery / 10.0) * 100).to_i #if self.plus_minus_count > 5
# minus_minus_level = ((self.minus_minus_mastery / 10.0) * 100).to_i #if self.minus_minus_count > 5
#
# plus_dbl_sq_level = ((self.plus_dbl_sq_mastery / 10.0) * 100).to_i #if self.plus_dbl_sq_count > 5
# minus_dbl_sq_level = ((self.minus_dbl_sq_mastery / 10.0) * 100 ).to_i #if self.minus_dbl_sq_count > 5
# diff_sq_level = ((self.diff_sq_mastery / 10.0) * 100).to_i #if self.diff_sq_count > 5
# a_greater_one_level = ((self.a_greater_one_mastery / 10.0) * 100).to_i #if self.a_greater_one_count > 5
#
# return {
#   plus_plus: plus_plus_level,
#   minus_plus: minus_plus_level,
#   minus_minus: minus_minus_level,
#   plus_minus: plus_minus_level,
#   minus_dbl_sq: minus_dbl_sq_level,
#   plus_dbl_sq: plus_dbl_sq_level,
#   diff_sq: diff_sq_level,
#   a_greater_one: a_greater_one_level,
#   total_problems: total_problems
# }
