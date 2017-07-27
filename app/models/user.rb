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
end
