class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }

  def update_mastery_levels(problem_info)
    pattern = problem_info["pattern"]
    self[pattern] += problem_info["score"]
    self.save
  end
end
