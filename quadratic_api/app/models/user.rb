class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  has_many :trinomials

  def update_mastery_levels(problem_info)
    ## add total problems as col for user table
    # self.total_problems += 1
    self.total_problems += 1
    pattern = problem_info["pattern"]
    self[pattern] += problem_info["score"]
    self.save
  end

  def generate_mastery_report

    return {
      plus_plus: self.mastery_plus_plus,
      minus_plus: self.mastery_minus_plus,
      minus_minus: self.mastery_minus_minus,
      plus_minus: self.mastery_plus_minus,
      minus_dbl_sq: self.mastery_minus_dbl_sq,
      plus_dbl_sq: self.mastery_plus_dbl_sq,
      diff_sq: self.mastery_diff_sq,
      gcf: self.mastery_gcf,
      total_problems_attempted: self.total_problems
    }
  end

  def generate_mastery_report_for_diagram
  end
end
