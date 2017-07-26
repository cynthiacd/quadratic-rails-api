class AddColUsersProblemsCorrectCount < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :total_problems_correct, :integer, default: 0
  end
end
