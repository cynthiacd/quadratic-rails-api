class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }

  def update_mastery_levels(problem_info)
    ## add total problems as col for user table
    # self.total_problems += 1
    # if problem_info["type"] == "standard"
    #   trinomial = self.trinomials.find_by(id: problem_info["id"])
    # elsif problem_info["type"] == "special"
    #   trinomial = self.special_trinomials.find_by(id: problem_info["id"])
    # end
    #
    # trinomial.solution_submitted = true
    # trinomial.save

    # the other option to tracking problems completed by pattern/total is
    # having table entries for the pattern count
    # could also drop relationship between user and trinomials
    # plus side to this - get ride of conditionals for trinomial type
    # able to generate report with only user table entries
    self.total_problems += 1
    pattern_count = problem_info["pattern"] + "_count"
    self[pattern_count] += 1

    pattern = problem_info["pattern"] + "_mastery"
    self[pattern] += problem_info["score"]
    self.save
  end

  def generate_mastery_report

    plus_plus_level = ((self.plus_plus_mastery.to_f / self.plus_plus_count) * 100).round(2) if self.plus_plus_count > 5
    minus_plus_level = ((self.minus_plus_mastery.to_f / self.minus_plus_count) * 100).round(2) if self.minus_plus_count != 0
    plus_minus_level = ((self.plus_minus_mastery.to_f / self.plus_minus_count) * 100).round(2) if self.plus_minus_count != 0
    minus_minus_level = ((self.minus_minus_mastery.to_f / self.minus_minus_count) * 100).round(2) if self.minus_minus_count != 0

    plus_dbl_sq_level = ((self.plus_dbl_sq_mastery.to_f / self.plus_dbl_sq_count) * 100).round(2) if self.plus_dbl_sq_count != 0
    minus_dbl_sq_level = ((self.minus_dbl_sq_mastery.to_f / self.minus_dbl_sq_count) * 100 ).round(2) if self.minus_dbl_sq_count != 0
    diff_sq_level = ((self.diff_sq_mastery.to_f / self.diff_sq_count) * 100).round(2) if self.diff_sq_count != 0
    a_greater_one_level = ((self.a_greater_one_mastery.to_f / self.a_greater_one_count) * 100).round(2) if self.a_greater_one_count != 0

    return {
      plus_plus: plus_plus_level,
      minus_plus: minus_plus_level,
      minus_minus: minus_minus_level,
      plus_minus: plus_minus_level,
      minus_dbl_sq: minus_dbl_sq_level,
      plus_dbl_sq: plus_dbl_sq_level,
      diff_sq: diff_sq_level,
      a_greater_one: a_greater_one_level,
      total_problems: total_problems
    }
  end
end
