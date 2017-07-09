class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }

  def update_mastery_levels(problem_info)
    # change grade to score or points
    score = problem_info["score"]
    pattern = problem_info["pattern"]
    if pattern == "plus_plus"
      self.mastery_plus_plus += score
      self.save
    end
  end
end
