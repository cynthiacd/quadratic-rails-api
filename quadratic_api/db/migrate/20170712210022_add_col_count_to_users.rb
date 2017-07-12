class AddColCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :total_problems, :integer
  end
end
