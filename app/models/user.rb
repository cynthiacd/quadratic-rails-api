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

  # you could divide by 10 - so 100% correlates with a score of +10
  def generate_mastery_report
    patterns = ["plus_plus",
                      "plus_minus",
                      "minus_plus",
                      "minus_minus",
                      "diff_sq",
                      "plus_dbl_sq",
                      "minus_dbl_sq",
                      "a_greater_one" ]
    report = {}
    patterns.each do |pattern|
      report[pattern] = ( ( self["#{pattern}_mastery"] / 10.0 ) * 100 ).to_i
    end
    report["total_problems"] = total_problems

    return report
  end
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
